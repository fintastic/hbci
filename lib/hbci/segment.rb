# frozen_string_literal: true

module Hbci
  class Segment
    extend Forwardable

    attr_reader :element_groups
    attr_reader :defined_element_groups
    attr_accessor :message
    attr_accessor :dialog

    attr_accessor :request_message

    def self.element_groups_to_be_defined
      @element_groups_to_be_defined ||= []
    end

    def self.element_group(name, definition = {}, &block)
      element_groups_to_be_defined << definition.merge(name: name, block: block)
    end

    def self.element(name, definition = {})
      element_groups_to_be_defined << definition.merge(name: name, block: nil, passthrough: true)
    end

    def build(message)
      self.request_message = message

      type, version = self.class.name.split('::').last.split('v')

      head.type = type
      head.version = version
    end

    def self.fill(segment_data)
      segment_data.each_with_object(new).with_index do |(element_group_data, segment), element_group_index|
        element_group_data.each_with_index do |element_data, element_index|
          segment.element_groups[element_group_index][element_index] = element_data
        end
      end
    end

    def initialize
      @element_groups = []
      @defined_element_groups ||= []
      define_element_groups
    end

    def compile; end

    def to_s
      element_groups.join('+').gsub(/\+*$/, '') << '\''
    end

    private

    def define_element_groups
      self.class.element_groups_to_be_defined.each { |element_group| define_element_group(element_group) }
    end

    def index_of_element_group(name)
      defined_element_groups.index(name)
    end

    def define_element_group(definition)
      defined_element_groups << definition[:name]

      if definition[:passthrough]
        initiate_passthrough_element_group(definition)
        define_element_group_passthrough_reader(definition[:name])
        define_element_group_passthrough_writer(definition[:name])
      else
        initiate_element_group(definition)
        define_element_group_reader(definition[:name])
        define_element_group_writer(definition[:name])
      end
    end

    def initiate_passthrough_element_group(definition)
      element_group = Hbci::ElementGroup.new
      element_group.define_element(definition)
      element_groups[index_of_element_group(definition[:name])] = element_group
    end

    def initiate_element_group(definition)
      element_group = definition[:type] ? definition[:type].new : Hbci::ElementGroup.new
      element_group.instance_eval(&definition[:block]) if definition[:block]
      element_groups[index_of_element_group(definition[:name])] = element_group
    end

    def define_element_group_passthrough_reader(name)
      define_singleton_method(name.to_s) do
        element_groups[index_of_element_group(name)][0]
      end
    end

    def define_element_group_reader(name)
      define_singleton_method(name.to_s) do
        element_groups[index_of_element_group(name)]
      end
    end

    def define_element_group_writer(name)
      define_singleton_method("#{name}=") do |value|
        element_groups[index_of_element_group(name)] = value
      end
    end

    def define_element_group_passthrough_writer(name)
      define_singleton_method("#{name}=") do |value|
        element_groups[index_of_element_group(name)][0] = value
      end
    end

    def after_build; end
  end
end
