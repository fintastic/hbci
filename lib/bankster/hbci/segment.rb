module Bankster
  module Hbci
    class Segment

      extend Forwardable
      def_delegator :@element_groups, :[]
      def_delegator :@element_groups, :[]=
      attr_accessor :element_groups
      attr_accessor :defined_element_groups
      attr_accessor :message
      attr_accessor :dialog

      class << self
        attr_accessor :element_groups_to_be_defined
      end

      def self.ensure_setup_element_group_definitions
        self.element_groups_to_be_defined = [] unless element_groups_to_be_defined.is_a?(Array)
      end

      def index_of_element_group(name)
        defined_element_groups.index(name)
      end

      def define_element_group_reader(name, pass = false)
        if pass
          define_singleton_method("#{name}") do
            element_groups[index_of_element_group(name)][0]
          end
        else
          define_singleton_method("#{name}") do
            element_groups[index_of_element_group(name)]
          end
        end
      end

      def define_element_group_writer(name, pass = false)
        if pass
          define_singleton_method("#{name}=") do |value|
            element_groups[index_of_element_group(name)][0] = value
          end
        else
          define_singleton_method("#{name}=") do |value|
            element_groups[index_of_element_group(name)] = value
          end
        end
      end

      def initiate_element_group(name, elements, block)
        element_group = Bankster::Hbci::ElementGroup.new do
          block.call if block
        end
        unless elements.nil? 
          elements.each { |el| element_group.define_element(el) }
        end
        self.element_groups[index_of_element_group(name)] = element_group
      end

      def define_element_group(definition)
        defined_element_groups << definition[:name]
        initiate_element_group(definition[:name], definition[:elements], definition[:block])
        if definition[:elements].is_a?(Array) && definition[:elements].count > 1 || definition[:block]
          define_element_group_reader(definition[:name])
          define_element_group_writer(definition[:name])
        else
          define_element_group_reader(definition[:name], true)
          define_element_group_writer(definition[:name], true)
        end
      end

      # Adds the element group to the list of EGs that need to be defined
      # at inistialization
      def self.element_group(name, definition = {}, &block)
        ensure_setup_element_group_definitions
        element_groups_to_be_defined << definition.merge({name: name, block: block})
      end

      def self.element(name)
        ensure_setup_element_group_definitions
        element_groups_to_be_defined << {elements: [name], name: name}
      end

      def define_element_groups_from_class
        self.class.element_groups_to_be_defined.each do |element_group|
          define_element_group(element_group)
        end
      end

      def initialize
        @defined_element_groups = []
        @element_groups = []

        define_element_groups_from_class
      end

      def self.type
        self.name.split('::').last.split('v').first
      end

      def self.version
        self.name.split('::').last.split('v').last
      end

      def self.build(dialog: nil, message: nil)
        segment = self.new
        segment.dialog = dialog
        segment.message = message

        segment.head.version = self.version
        segment.head.type = self.type

        segment.after_build
        segment
      end

      def to_s
        element_groups.map{ |eg| eg.elements.join(':') }.join('+') << '\''
      end
    end
  end
end
