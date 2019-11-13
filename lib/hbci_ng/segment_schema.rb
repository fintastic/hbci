module HbciNg
  module SegmentSchema
    extend ActiveSupport::Concern

    included do
      @schema = []
      add('Segmentkopf') do |eg|
        eg.add('Segmentkennung')
        eg.add('Segmentnummer')
        eg.add('Segmentversion')
        eg.add('Bezugssegment')
      end
    end

    class_methods do
      def schema
        @schema
      end

      # def add_element_group(name)
      #   eg = ElementGroupSchema.new(name, @schema.length)
      #   yield eg
      #   @schema << eg
      # end
      #
      # def element_group(name)
      #   @schema.each do |eg|
      #     return eg if eg.name == name
      #   end
      # end
      #
      # def add_element(name)
      #   @schema << ElementSchema.new(name, @schema.length)
      # end
      #
      # def element(name)
      #   @schema.each do |e|
      #     return e if e.name == name
      #   end
      # end

      def add(name)
        if block_given?
          e = ElementGroupSchema.new(name, @schema.length)
          yield e
        else
          e = ElementSchema.new(name, @schema.length)
        end
        @schema << e
      end

      def get(name)
        @schema.each do |e|
          return e if e.name == name
        end
      end

      def find_by_name(name)
        @schema.each do |e|
          return e if e.name == name
        end
      end
    end
  end
end
