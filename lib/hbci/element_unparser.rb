# frozen_string_literal: true

module Hbci
  class ElementUnparser
    attr_reader :element
    attr_reader :type

    def initialize(element, type)
      @element = element
      @type = type
    end

    def unparse
      if type == :binary
        "@#{element.size}@#{element}"
      else
        element.to_s.gsub('?', '??').gsub('+', '?+').gsub(':', '?:').gsub('\'', '?\'')
      end
    end
  end
end
