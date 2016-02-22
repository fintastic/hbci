require 'parslet'

module Bankster
  module Hbci
    class Parser < Parslet::Parser
      root :segments

      rule(:segments) { segment.as(:segment).repeat(1) }

      rule(:segment) do
        (segment_delimiter.absent? >> segment_content).repeat(1) >> segment_delimiter
      end

      rule(:segment_content) do
        element_group.as(:element_group) >> (element_group_delimiter >> element_group.repeat(0,1).as(:element_group)).repeat
      end

      rule(:element_group) do
        element.as(:element) >> (element_delimiter >> element.maybe.as(:element)).repeat
      end

      rule(:regular_element) do
        (end_of_element.absent? >> element_char).repeat(1)
      end

      rule(:binary_element) do
        binary_length >> dynamic do |_, context|
          any.repeat(context.captures[:length].to_i, context.captures[:length].to_i)
        end
      end

      rule(:element)                 { (binary_length.absent? >> regular_element ) | binary_element }
      rule(:binary_length)           { str('@') >> integer.capture(:length) >> str('@') }
      rule(:escaped_reserved)        { escaper >> reserved }
      rule(:reserved)                { delimiter | escaper }
      rule(:end_of_element)          { delimiter }
      rule(:delimiter)               { segment_delimiter | element_group_delimiter | element_delimiter }
      # rule(:element_char)            { escaped_reserved | match('[a-zA-Z0-9]') }
      rule(:element_char)            { escaped_reserved | any }
      rule(:segment_delimiter)       { str('\'') }
      rule(:element_group_delimiter) { str('+') }
      rule(:element_delimiter)       { str(':') }
      rule(:escaper)                 { str('?') }
      rule(:integer)                 { digit.repeat(1) }
      rule(:digit)                   { match('[0-9]')  }
      rule(:eof)                     { any.absent?  }
    end
  end
end
