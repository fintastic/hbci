# frozen_string_literal: true

module Hbci
  module Segments
    class HNVSDv1 < Segment
      attr_reader :segments

      element_group :head, type: ElementGroups::SegmentHead
      element :content, type: :binary

      def initialize
        super()
        @segments = []
        yield self if block_given?
      end

      def find(segment_type)
        segments = find_all(segment_type)
        warn "more then one #{segment_type} segment available" if segments.size > 1
        segments.first
      end

      def find_all(segment_type)
        @raw_segments = Parser.parse(content)
        @raw_segments.select { |sd| sd[0][0] == segment_type }.map{ |sd| Hbci::SegmentFactory.build(sd) }
      end

      def add_segment(segment)
        segment.build(self)
        @segments.push(segment)
      end

      def compile
        head.position = 999
        @segments.each_with_index do |segment, _index|
          segment.request_message = request_message
          segment.compile
          unless segment.head.position
            segment.head.position = request_message.next_position
            request_message.next_position += 1
          end
        end
        @segments.each do |segment|
          segment.after_compile if segment.respond_to?(:after_compile)
        end
        self.content = @segments.join('')
      end
    end
  end
end
