module HbciNg
  class Segment
    attr_reader :element_groups

    def initialize(data = nil)
      @subjects = []
      @element_groups = []
      fill(data) if data
    end

    def find_by_index(index)
      @subjects.fetch(index)
    rescue IndexError
      raise ElementGroupError, "index #{index} does not exists"
    end

    def find_by_name(name)
      segment_type = find_by_index(0).find_by_index(0).value
      segment_version = find_by_index(0).find_by_index(2).value

      segment_class = Object.const_get("HbciNg::Segments::#{segment_type}v#{segment_version}")

      element_names = name.split('/')

      subject = self
      element_names.each.with_index do |name, index|
        segment_class = segment_class.find_by_name(name)
        subject = subject.find_by_index(segment_class.index)
      end
      subject
    end

    def fill(data)
      data = data.delete("\n").delete("\s")
      cursor = 0
      next_stop = 0
      cursor_meta_data = nil
      data.each_char.with_index do |c, index|
        next if index < next_stop

        if c == '@' && !cursor_meta_data.nil?
          next_stop = index + data[cursor_meta_data + 1..index - 1].to_i + 1
          cursor_meta_data = nil
        elsif c == '@' && cursor_meta_data.nil?
          cursor_meta_data = index
        end

        next unless c == '+' || data.size == index + 1

        @subjects << Subject.new(data[cursor..index - 1])
        cursor = index + 1
      end
    end

    # def element_group(index)
    #   @element_groups.fetch(index)
    # rescue IndexError
    #   raise ElementGroupError, "element group on position #{index} does not exists"
    # end
    #
    # def add_element_group(index, element_group)
    #   @element_groups[index] = element_group
    # end

    def to_hbci
      hbci = String.new
      @subjects.each.with_index do |subject, index|
        hbci << subject.to_hbci
        hbci << '+' if index != @subjects.length - 1
      end
      hbci << "'"
      hbci
    end
  end
end
