module Bankster
  module Hbci
    # An ElementGroup contains any number of elements.
    #
    # Every Element can be accessed via one of the folloging methods:
    #
    # - named reader:
    #   element_group.element_name
    #
    # - named writer:
    #   element_group.element_name = "asd"
    #
    # - array reader:
    #   element_group[index_of_element]
    #
    # - array writer:
    #   element_group[index_of_element] = "asd"
    #
    #
    # By default, an ElementGroup does not have any elements. They need to be
    # configured. This can be done by 2 ways:
    #
    # 1. Define them on class level by subclassing ElementGroup
    #
    #   class MyElementGroup < ElementGroup
    #     element :my_first_element
    #     element :my_second_element
    #   end
    #
    # 2. Define them dynamically:
    #
    #   my_element_group = ElementGroup.new
    #   my_element_group.define_element(:my_first_element)
    #   my_element_group.define_element(:my_second_element)
    class ElementGroup
      extend Forwardable
      def_delegator :@elements, :[]
      def_delegator :@elements, :[]=
      attr_accessor :elements
      attr_accessor :defined_elements

      @elements_to_be_defined = []

      class << self
        attr_accessor :elements_to_be_defined
      end

      def self.ensure_setup_of_elements_to_be_defined
        self.elements_to_be_defined = [] unless elements_to_be_defined.is_a?(Array)
      end

      def self.element(name, definition = {})
        ensure_setup_of_elements_to_be_defined
        elements_to_be_defined << definition.merge(name: name)
      end

      def self.elements(name, definition = {})
        ensure_setup_of_elements_to_be_defined
        elements_to_be_defined << definition.merge(name: name, multi: true)
      end

      def element(name, definition = {})
        define_element(definition.merge(name: name))
      end

      def define_elements_from_class
        self.class.elements_to_be_defined.each { |el| define_element(el) }
      end

      def define_element(definition)
        defined_elements << definition
        set_element_default(definition)
      end

      def to_s
        element_strings = elements.each_with_index.map do |element, index|
          if element.is_a?(Array)
            element.map { |entry| ElementUnparser.new(entry, defined_elements[index][:type]).unparse }
          else
            ElementUnparser.new(element, defined_elements[index][:type]).unparse
          end
        end
        element_strings.join(':').gsub(/:*$/, '')
      end

      def initialize
        @defined_elements = []
        @elements = []

        define_elements_from_class
      end

      def respond_to?(name, include_all=false)
        potential_element_name = name.to_s.split('=').first.to_sym

        !!index_for_element(potential_element_name) || super
      end

      private

      def get_element(name)
        elements[index_for_element(name)]
      end

      def set_element(name, value)
        elements[index_for_element(name)] = value
      end

      def method_missing(name, *args)
        potential_element_name = name.to_s.split('=').first.to_sym
        is_writer = (name[-1..-1] == '=')

        if index = index_for_element(potential_element_name)
          return set_element(potential_element_name, args.first) if is_writer && args.count == 1
          return get_element(potential_element_name)
        end

        super
      end

      def set_element_default(definition)
        default = case
                  when definition[:multi] then []
                  when definition[:default].is_a?(Proc) then definition[:default].call(self)
                  else definition[:default]
                  end

        set_element(definition[:name], default)
      end

      def index_for_element(name)
        defined_elements.index { |el| el[:name] == name }
      end
    end
  end
end
