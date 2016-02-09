module Bankster
  module Hbci
    module Segments
      class HIKAZv6 < Segment
        element_group :head, type: ElementGroups::SegmentHead
        element :booked, type: :binary
        element :noted, type: :binary
      end
    end
  end
end
