module HbciNg
  class Message
    def initialize(data = nil)
      @segments = []
      fill(data) if data
    end

    def fill(message_data)
      @message_data = message_data.delete("\n").delete("\s")

      cursor = 0
      cursor_meta_data = nil
      next_stop = 0
      @message_data.each_char.with_index do |c, index|
        next if index < next_stop

        if c == '@' && !cursor_meta_data.nil?
          next_stop = index + @message_data[cursor_meta_data + 1..index - 1].to_i + 1
          cursor_meta_data = nil
        elsif c == '@' && cursor_meta_data.nil?
          cursor_meta_data = index
        end

        next unless c == "'"

        @segments << Segment.new(@message_data[cursor..index])
        cursor = index + 1
      end
    end

    def segments(name)
      @segments.select { |s| s.find_by_index(0).find_by_index(0).value == name }
    end

    def segment(index)
      @segments.fetch(index)
    rescue IndexError
      raise ElementGroupError, "segment on position #{index} does not exists"
    end

    def add_segment(segment)
      @segments << segment
    end

    def to_hbci
      @segments.map(&:to_hbci).join
    end

    def to_base64
      Base64.encode64(to_hbci)
    end
  end
end
