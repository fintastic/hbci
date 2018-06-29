module Hbci
  module Segments
    class HISALSv4 < Segment
      element_group :head, type: ElementGroups::SegmentHead
      element :max_entries
      element :min_signatures
      element :security_class
    end

    class HISALSv7 < Segment
      element_group :head, type: ElementGroups::SegmentHead
      element :max_entries
      element :min_signatures
      element :security_class
    end
  end
end
