# frozen_string_literal: true

module Hbci
  module Segments
    module SegmentHead
      def self.included(klass)
        klass.element_group :head, type: ElementGroups::SegmentHead
      end
    end
  end
end
