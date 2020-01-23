module Hbci
  class Message
    def self.parse(hbci)
      message = Message.new
      Parser.parse(hbci, "'") do |data|
        message << Segment.parse(data)
      end
      message
    end

    def initialize
      @segments = []
    end

    def []=(idx, segment)
      @segments[idx - 1] = segment.is_a?(Segment) ? segment : Segment.parse(segment)
    end

    def [](idx)
      @segments[idx - 1]
    end

    def <<(segment)
      @segments << (segment.is_a?(Segment) ? segment : Segment.parse(segment))
    end

    def each(&block)
      @segments.each(&block)
    end

    def to_base64
      Base64.encode64(to_s)
    end

    def to_s
      @segments.map(&:to_s).join
    end

    def find_segments(name)
      @segments.select do |segment|
        segment[1][1] == name
      end
    end
  end
end
