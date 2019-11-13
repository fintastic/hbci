module HbciNg
  class Subject
    attr_accessor :value
    attr_reader :bin

    def initialize(data = nil)
      @subjects = []
      @bin = false
      fill(data) if data
    end

    def find_by_index(index)
      @subjects.fetch(index)
    rescue IndexError
      raise ElementGroupError, "index #{index} does not exists"
    end

    def fill(data)
      cursor = 0
      if !data.include?(':') || data[0] == '@'
        if data[0] == '@'
          @bin = true
          @value = data.gsub!(/^@[0-9]*@/, '')
        else
          @value = data
        end
        return
      end

      data.each_char.with_index do |c, index|
        if c == ':'
          @subjects << self.class.new(data[cursor..index - 1])
          cursor = index + 1
        elsif data.size == index + 1
          @subjects << self.class.new(data[cursor..index])
          cursor = index + 1
        end
      end
    end

    def to_hbci
      return @bin ? "@#{@value.size}@#{@value}" : @value if @subjects.empty?

      hbci = String.new
      @subjects.each.with_index do |subject, index|
        hbci << subject.to_hbci
        hbci << ':' if index != @subjects.length - 1
      end
      hbci
    end
  end
end
