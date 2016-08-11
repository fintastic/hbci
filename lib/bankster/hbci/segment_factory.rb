module Bankster
  module Hbci
    class SegmentFactory
      def self.build(segment_data)
        segment_class_name = "#{segment_data[0][0]}v#{segment_data[0][2]}"
        segment_class = begin
                          Object.const_get("Bankster::Hbci::Segments::#{segment_class_name}")
                        rescue
                          Bankster::Hbci::Segments::Unknown
                        end
        segment_class.fill(segment_data)
      end
    end
  end
end
