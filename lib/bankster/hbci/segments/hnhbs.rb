module Bankster
  module Hbci
    module Segments
      class HNHBSv1 < Segment
        element_group :head, type: ElementGroups::SegmentHead
        element :message_number

        def after_build
          self.head.position = message.payload.size + 4
          self.message_number = dialog.next_sent_message_number
        end
      end
    end
  end
end