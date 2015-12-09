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

      def index_for_element(name)
        defined_elements.index(name)
      end

      def element(*args)
        define_element(*args)
      end

      def define_element(params)
        if params.is_a?(Symbol)
          name = params
        else
          name = params[:name]
        end

        defined_elements << name

        define_singleton_method("#{name}") do
          elements[index_for_element(name)]
        end

        define_singleton_method("#{name}=") do |value|
          elements[index_for_element(name)] = value
        end

        if params.is_a?(Hash) && params[:default]
          elements[index_for_element(params[:name])] = params[:default]
        end
      end

      def initialize
        @defined_elements = []
        @elements = []

        define_elements_from_class
      end

      private

      def define_elements_from_class
        self.class.elements_to_be_defined.each do |element|
          define_element(element)
        end
      end
    end
  end
end
