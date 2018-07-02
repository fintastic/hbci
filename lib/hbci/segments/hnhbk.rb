# frozen_string_literal: true

module Hbci
  module Segments
    class HNHBKv3 < Segment
      element_group :head, type: Hbci::ElementGroups::SegmentHead
      element :message_size
      element :hbci_version, default: 300
      element :dialog_id
      element :message_number
      element_group :referenced_message do
        element :dialog_id
        element :message_number
      end

      def after_build
        set_message_length
        self.dialog_id = dialog.id
        self.message_number = dialog.next_sent_message_number
        head.position = 1
        head.version = 3
      end

      private

      def set_message_length
        self.message_size = calculate_message_length.to_s.rjust(12, '0')
      end

      def calculate_message_length
        hnhbk_length + message.encrypted_payload.to_s.size + message.enc_head.to_s.size
      end

      def hnhbk_length
        head_length = 30
        tail_length = 11
        head_length + tail_length + dialog.next_sent_message_number.to_s.size + dialog.id.to_s.size
      end
    end
  end
end
