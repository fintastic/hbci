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

        segment_class = registered_segments.select{ |segment| segment[:type] == type && segment[:version].to_s == version }.first[:class]

        segment = segment_class.new
        
        segment_data.each_with_index do |element_group_data, element_group_index|
          element_group_data.each_with_index do |element_data, element_index|
            segment[element_group_index][element_index] = element_data
          end
        end

        segment
      end
    end
  end
end
