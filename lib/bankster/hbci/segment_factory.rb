module Bankster
  module Hbci
    class SegmentFactory
      def self.build(segment_data)
        candidates = Segment.descendants.select do |s|
          s.type == segment_data[0][0] && s.version == segment_data[0][2]
        end
        case
        when candidates.count == 1
          candidates.first.parse(segment_data)
        when candidates.count > 1
          raise "Ambiguous class candidates for #{segment_data[0][0]} in version #{segment_data[0][2]}"
        when candidates.count == 0
          Bankster::Hbci::Segments::Unknown.parse(segment_data)
        end
      end
    end
  end
end
