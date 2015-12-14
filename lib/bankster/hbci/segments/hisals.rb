module Bankster
  module Hbci
    module Segments
      class HISALSv4 < Segment
        include SegmentHead
        include HIParams1
      end

      class HISALSv7 < Segment
        include SegmentHead
        include HIParams2
      end
    end
  end
end


