# frozen_string_literal: true

module Hbci
  module Segments
    class HKENDv1 < Segment
      element_group :head, type: ElementGroups::SegmentHead
      element :dialog_id

      def compile
        self.dialog_id = request_message.dialog.id
      end
    end
  end
end
