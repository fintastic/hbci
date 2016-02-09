require 'parslet'

module Bankster
  module Hbci
    class Transform < Parslet::Transform
      rule(:element_content => simple(:element_content)) do |element|
        element[:element_content].to_s
      end

      rule(:element_group_content => sequence(:element_group_content)) do |c|
        c[:element_group_content]
      end

      rule(:element_group_content => simple(:element_group_content)) do |c|
        [c[:element_group_content]]
      end

      rule((:segment) => subtree(:segment)) do |s|
        s[:segment]
      end
    end

    class Parser < Parslet::Parser
      root :segments

      rule(:segments) { segment.as(:segment).repeat(1) }

      rule(:segment) do
        (segment_delimiter.absent? >> segment_content).repeat(1) >> segment_delimiter
      end

      rule(:segment_content) do
        element_group >> (element_group_delimiter >> element_group).repeat
      end

      rule(:element_group) do
        (element >> (element_delimiter >> element).repeat).as(:element_group_content)
      end

      rule(:regular_element_content) do
        binary_length.absent? >> ((end_of_element.absent? >> element_content_char).repeat(1)).as(:element_content)
      end

      rule(:binary_element_content) do
        binary_length >> dynamic do |_, context|
          any.repeat(context.captures[:length].to_i, context.captures[:length].to_i).as(:element_content)
        end
      end

      rule(:element)                 { regular_element_content | binary_element_content }
      rule(:binary_length)           { str('@') >> integer.capture(:length) >> str('@') }
      rule(:escaped_reserved)        { escaper >> reserved }
      rule(:reserved)                { delimiter | escaper }
      rule(:end_of_element)          { delimiter }
      rule(:delimiter)               { segment_delimiter | element_group_delimiter | element_delimiter }
      rule(:element_content_char)    { escaped_reserved | any }
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
