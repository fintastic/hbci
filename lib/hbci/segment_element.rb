module Hbci
  class SegmentElement
    attr_accessor :create_data_block

    def self.parse(hbci)
      segment_element = SegmentElement.new
      if hbci[0] == '@'
        segment_element.create_data_block = true
        segment_element << hbci.sub(/@[0-9]+@/, '')
      else
        Parser.parse(hbci, ':') do |data|
          segment_element << data.gsub('??', '?').gsub('?:', ':').gsub("?'", "'").gsub('?+', '+')
        end
      end
      segment_element
    end

    def initialize(*args)
      @values = []
      args.each { |value| self << value }
    end

    def init_data_block(hbci)
      @create_data_block = true
      self << hbci
      self
    end

    def []=(idx, value)
      @values[idx - 1] = (value.is_a?(SegmentElement) ? value : value.to_s)
    end

    def [](idx)
      @values[idx - 1]
    end

    def <<(value)
      @values << value.to_s
    end

    def to_s
      return unless @values
      return "@#{@values.first.to_s.size}@#{@values.first}" if create_data_block?

      @values.map{ |v| v.is_a?(SegmentElement) ? v : v.gsub('+', '?+').gsub(':', '?:') }.join(@values.size > 1 ? ':' : '')
    end

    private

    def create_data_block?
      @create_data_block
    end
  end
end
