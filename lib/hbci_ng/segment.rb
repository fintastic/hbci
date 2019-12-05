module HbciNg
  class Segment
    def initialize(hbci = nil)
      @elements = []
      build(hbci) if hbci
    end

    def head(name, position, version)
      self[1] = "#{name}:#{position}:#{version}"
      self
    end

    def init(*args)
      args.each { |value| self << value }
      self
    end

    def []=(idx, value)
      @elements[idx - 1] = SegmentElement.new(value)
    end

    def [](idx)
      @elements[idx - 1] = SegmentElement.new unless @elements[idx - 1]
      @elements[idx - 1]
    end

    def <<(value)
      @elements << SegmentElement.new(value)
    end

    def add_data_block(idx, value)
      @elements[idx - 1] = SegmentElement.new(value, data_block: true)
    end

    def to_s
      @elements.join('+') + "'"
    end

    private

    def build(hbci)
      Parser.parse(hbci, '+') do |data|
        self << data
      end
    end
  end
end

