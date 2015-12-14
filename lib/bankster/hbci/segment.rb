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

      def initiate_element_group(name, elements, block, type = nil)
        element_group_class = type ? type : Bankster::Hbci::ElementGroup
        element_group = element_group_class.new
        element_group.instance_eval(&block) if block 
        elements.to_a.each { |el| element_group.define_element(el) }
        self.element_groups[index_of_element_group(name)] = element_group
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
        element_groups_to_be_defined << definition.merge({name: name, block: block})
      end

      def self.element(name, definition = {})
        ensure_setup_element_group_definitions
        element_groups_to_be_defined << {elements: [definition.merge({name: name})], name: name}
      end

      def define_element_groups_from_class
        self.class.element_groups_to_be_defined.each do |element_group|
          define_element_group(element_group)
        end
      end

      def after_build
      end

      def initialize
        @defined_element_groups = []
        @element_groups = []

        define_element_groups_from_class
      end

      def self.type
        self.name.split('::').last.split('v').first rescue "EmptySegment"
      end

      def self.version
        self.name.split('::').last.split('v').last rescue "0"
      end

      def self.build(dialog: nil, message: nil, **)
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

      def self.inherited(subclass)
        SegmentParser.register_segment(type: subclass.type, version: subclass.version, class: subclass)
        super
      end

      def self.parse(string)
        string.chomp!('\'')
        segment_data = string.split('+').map{ |deg| deg.split(':') }
        segment = self.new
        
        segment_data.each_with_index do |element_group_data, element_group_index|
          unless segment[element_group_index].is_a?(ElementGroup)
            raise "Failed to add a parsed element group to segment #{segment.class.type}v#{segment.class.version} at index #{element_group_index}"
          end
          element_group_data.each_with_index do |element_data, element_index|
            if element_index > segment[element_group_index].elements.size 
              raise "Failed to add a parsed element to element_group #{segment.class.type}v#{segment.class.version} at element_group #{element_group_index} index #{element_index}"
            end
            segment[element_group_index][element_index] = element_data 
          end
        end

        segment
      end
    end
  end
end
