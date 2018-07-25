
# frozen_string_literal: true

module Hbci
  class Response
    def initialize(raw_response)
      @raw_response = raw_response
      @raw_segments = Parser.parse(raw_response.force_encoding('iso-8859-1'))
    end

    def find(segment_type)
      segments = find_all(segment_type)
      warn "more then one #{segment_type} segment available" if segments.size > 1
      segments.first
    end

    def find_all(segment_type)
      @raw_segments.select { |sd| sd[0][0] == segment_type }.map{ |sd| Hbci::SegmentFactory.build(sd) }
    end

    def to_s
      @raw_response
    end
  end
end
