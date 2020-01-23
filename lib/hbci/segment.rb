module Hbci
  class Segment
    def self.parse(hbci)
      segment = Segment.new
      Parser.parse(hbci, '+') do |data|
        segment << SegmentElement.parse(data)
      end
      segment
    end

    def initialize
      @elements = []
    end

    def head(name, position, version)
      self[1] = [name, position, version]
      self
    end

    def init(*args)
      args.each { |value| self << value }
      self
    end

    def []=(idx, value)
      @elements[idx - 1] = (value.is_a?(SegmentElement) ? value : SegmentElement.new(*value))
    end

    def [](idx)
      @elements[idx - 1] = SegmentElement.new unless @elements[idx - 1]
      @elements[idx - 1]
    end

    def <<(value)
      @elements << (value.is_a?(SegmentElement) ? value : SegmentElement.new(*value))
    end

    def add_data_block(idx, value)
      @elements[idx - 1] = SegmentElement.new.init_data_block(value)
    end

    def to_s
      @elements.join('+') + "'"
    end
  end
end

