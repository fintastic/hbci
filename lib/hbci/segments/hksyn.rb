# frozen_string_literal: true

module Hbci
  module Segments
    class HKSYNv3 < Segment
      element_group :head, type: ElementGroups::SegmentHead
      element :mode

      def compile
        self.mode = 0
      end
    end
  end
end
