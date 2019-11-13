module HbciNg
  class ElementSchema
    attr_reader :name, :index

    def initialize(name, index)
      @name = name
      @index = index
    end
  end
end
