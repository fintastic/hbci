module Hbci
  class Parser
    def self.parse(hbci, seperator, &block)
      new(hbci, seperator).parse(&block)
    end

    def initialize(hbci, seperator)
      @hbci = hbci
      @seperator = seperator
      @start_position = nil
      @skip_until_position = nil
      @ignore_next_char = false
    end

    def parse
      cursor = 0
      @hbci.each_char.with_index do |c, index|
        next if skip?(c, index)

        if @hbci[index] == @seperator
          yield @hbci[cursor..index - 1]
        else
          yield @hbci[cursor..index]
        end
        cursor = index + 1
      end
    end

    private

    def skip?(c, index)
      return false if @hbci.size - 1 == index
      return true if @skip_until_position && index <= @skip_until_position

      if @ignore_next_char
        @ignore_next_char = false
        return true
      end

      if c == '?'
        @ignore_next_char = true
        return true
      end

      @skip_until_position = nil
      if c == '@'
        if @start_position.nil?
          @start_position = index
        else
          @skip_until_position = index + @hbci[@start_position + 1..index - 1].to_i
          @start_position = nil
        end
      end

      c != @seperator
    end
  end
end
