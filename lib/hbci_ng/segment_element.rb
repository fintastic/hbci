module HbciNg
  class SegmentElement
    def initialize(content = [], data_block: false)
      @values = []
      @create_data_block = data_block

      if content.nil?
        self << nil
      elsif !data_block
        content = content.to_s.include?(':') && content[0] != '@' ? content.split(':') : [content] if content.is_a?(String) || content.is_a?(Integer)
        content.each { |value| self << value }
      else
        self << content
      end
    end

    def []=(idx, value)
      @values[idx - 1] = value.to_s
    end

    def [](idx)
      @values[idx - 1]
    end

    def <<(value)
      @values << value.to_s
    end

    def to_s
      return unless @values

      if create_data_block?
        "@#{@values.first.to_s.size}@#{@values.first}"
      else
        @values.size > 1 ? @values.join(':') : @values.first.to_s
      end
    end

    private

    def create_data_block?
      @create_data_block
    end
  end
end
