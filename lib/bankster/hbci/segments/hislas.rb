module Bankster
  module Hbci
    module Segments
      class HISLASv4 < Segment
        include SegmentHead
        include MultiDiretDebitParams
        include HIParams1
      end
    end
  end
end
