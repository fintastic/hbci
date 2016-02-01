module Bankster
  module Hbci
    class SegmentParser
      @registered_segments = []

      class << self
        attr_accessor :registered_segments
      end

      def self.cleanup
        self.registered_segments = []
      end

      def self.register_segment(segment)
        registered_segments << segment
      end

      def self.parse(string)
        string.chomp!('\'')
        segment_data = string.split('+').map{ |deg| deg.split(':') }
        type = segment_data[0][0]
        version = segment_data[0][2]

        segment_class_matches = registered_segments.select{ |segment| segment[:type] == type && segment[:version].to_s == version }
        
        # raise "No registered segment class for #{type} in version #{version}" if segment_class_matches.count == 0
        if segment_class_matches.none?
          return []
        end

        raise "Multiple registered segment classes for #{type} in version #{version}" if segment_class_matches.count > 1

        segment_class = segment_class_matches.first[:class]
        segment_class.parse(string)
      end
    end
  end
end
