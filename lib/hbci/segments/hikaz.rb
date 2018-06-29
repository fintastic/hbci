module Hbci
  module Segments
    class HIKAZv4 < Segment
      element_group :head, type: ElementGroups::SegmentHead
      element :booked
      element :notbooked
    end

    class HIKAZv5 < Segment
      element_group :head, type: ElementGroups::SegmentHead
      element :booked
      element :notbooked
    end

    class HIKAZv6 < Segment
      element_group :head, type: ElementGroups::SegmentHead
      element :booked
      element :notbooked
    end

    class HIKAZv7 < Segment
      element_group :head, type: ElementGroups::SegmentHead
      element :booked
      element :notbooked
    end
  end
end
