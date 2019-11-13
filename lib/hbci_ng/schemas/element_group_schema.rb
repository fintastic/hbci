module HbciNg
  class ElementGroupSchema
    attr_reader :name, :index

    def initialize(name, index)
      @name = name
      @index = index
      @elements = []
      @element_groups = []
    end

    # def add_element(name)
    #   @elements << ElementSchema.new(name, @elements.length)
    # end
    #
    # def element(name)
    #   @elements.each do |e|
    #     return e if e.name == name
    #   end
    # end

    def add(name)
      if block_given?
        e = ElementGroupSchema.new(name, @element_groups.length)
        yield e
        @element_groups << e
      else
        @elements << ElementSchema.new(name, @elements.length)
      end
    end

    # def get(name)
    #   @elements.each do |e|
    #     return e if e.name == name
    #   end
    # end

    def find_by_name(name)
      @element_groups.each do |e|
        return e if e.name == name
      end
      @elements.each do |e|
        return e if e.name == name
      end
    end
  end
end
