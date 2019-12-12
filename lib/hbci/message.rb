module Hbci
  class Message
    def initialize(hbci = nil)
      @segments = []
      build(hbci) if hbci
    end

    def []=(idx, segment)
      @segments[idx - 1] = segment.is_a?(Segment) ? segment : Segment.new(segment)
    end

    def [](idx)
      @segments[idx - 1]
    end

    def <<(segment)
      @segments << Segment.new(segment)
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

    private

    def build(hbci)
      Parser.parse(hbci, "'") do |data|
        self << data
      end
    end
  end
end
