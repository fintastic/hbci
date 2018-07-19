# frozen_string_literal: true

module Hbci
  module Segments
    class HNHBSv1 < Segment
      element_group :head, type: ElementGroups::SegmentHead
      element :message_number

      def compile
        self.message_number = Connector.instance.message_number
      end
    end
  end
end
