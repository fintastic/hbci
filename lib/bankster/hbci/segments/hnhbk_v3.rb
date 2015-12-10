module Bankster
  module Hbci
    module Segments
      class HNHBKv3 < Segment
        element_group :head, type: Bankster::Hbci::ElementGroups::SegmentHead
        element :message_size
        element :hbci_version, default: 300
        element :dialog_id
        element :message_number

        def after_build
          self.head.position = 1
          self.head.version = 3

          head_length = 29
          tail_length = 11
          length = head_length + tail_length + dialog.next_sent_message_number.size * 2 + dialog.id.size + message.encrypted_payload.to_s.size + message.enc_head.to_s.size
          self.message_size = length.to_s.rjust(12, "0")
          self.dialog_id = dialog.id
          self.message_number = dialog.next_sent_message_number
        end
      end
    end
  end
end
