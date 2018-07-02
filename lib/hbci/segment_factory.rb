# frozen_string_literal: true

module Hbci
  class SegmentFactory
    def self.build(segment_data)
      segment_class_name = "#{segment_data[0][0]}v#{segment_data[0][2]}"
      segment_class = begin
                        Object.const_get("Hbci::Segments::#{segment_class_name}")
                      rescue
                        Hbci::Segments::Unknown
                      end
      segment_class.fill(segment_data)
    end
  end
end
