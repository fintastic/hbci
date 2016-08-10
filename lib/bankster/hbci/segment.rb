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
        define_singleton_method(name.to_s) do
          if pass
            element_groups[index_of_element_group(name)][0]
          else
            element_groups[index_of_element_group(name)]
          end
        end
      end

      def define_element_group_writer(name, pass = false)
        define_singleton_method("#{name}=") do |value|
          if pass
            element_groups[index_of_element_group(name)][0] = value
          else
            element_groups[index_of_element_group(name)] = value
          end
        end
      end

      def initiate_element_group(name, element_definitions, block, type = nil)
        element_group = type ? type.new : Bankster::Hbci::ElementGroup.new
        element_group.instance_eval(&block) if block
        element_definitions.to_a.each do |element_definition|
          element_definition = { name: element_definition } if element_definition.is_a?(Symbol)
          element_group.define_element(element_definition)
        end
        element_groups[index_of_element_group(name)] = element_group
      end

      def define_element_group(definition)
        defined_element_groups << definition[:name]

        initiate_element_group(definition[:name], definition[:elements], definition[:block], definition[:type])

        byepass = definition[:elements].is_a?(Array) && definition[:elements].count == 1
        define_element_group_reader(definition[:name], byepass)
        define_element_group_writer(definition[:name], byepass)
      end

      # Adds the element group to the list of EGs that need to be defined
      # at inistialization
      def self.element_group(name, definition = {}, &block)
        ensure_setup_element_group_definitions
        element_groups_to_be_defined << definition.merge(name: name, block: block)
      end

      def self.element_groups(name, definition = {}, &block)
        ensure_setup_element_group_definitions
        element_groups_to_be_defined << definition.merge(name: name, block: block, multi: true)
      end

      def self.element(name, definition = {})
        ensure_setup_element_group_definitions
        element_groups_to_be_defined << { elements: [definition.merge(name: name)], name: name }
      end

      def define_element_groups_from_class
        self.class.element_groups_to_be_defined.each { |element_group| define_element_group(element_group) }
      end

      def after_build
      end

      def initialize
        @defined_element_groups = []
        @element_groups = []

        define_element_groups_from_class
      end

      def self.type
        name.split('::').last.split('v').first
      end

      def self.version
        name.split('::').last.split('v').last
      end

      def self.build(dialog: nil, message: nil, **)
        segment = new
        segment.dialog = dialog
        segment.message = message

        segment.head.version = version
        segment.head.type = type

        segment.after_build
        segment
      end

      def to_s
        element_groups.join('+').gsub(/\+*$/, '') << '\''
      end

      def self.parse(segment_data)
        segment = new

        segment_data.each_with_index do |element_group_data, element_group_index|
          element_group_data.each_with_index do |element_data, element_index|
            element_data = element_data.gsub('??', '?').gsub('?:', ':').gsub("?'", "'").gsub('?+', '+') if element_data.is_a?(String)
            segment[element_group_index][element_index] = element_data
          end
        end
        segment
      end
    end
  end
end
