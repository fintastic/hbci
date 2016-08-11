module Bankster
  module Hbci
    class Parser
      attr_reader :scanner
      attr_accessor :segments

      ELEMENT_DELIMITER       = ':'.freeze
      ELEMENT_GROUP_DELIMITER = '+'.freeze
      SEGMENT_DELIMITER       = '\''.freeze

      # ELEMENT_REGEX matches everything until a a delimiter that is not escaped
      #
      # NODE                     EXPLANATION
      # ------------------------------------------------------------------------
      #   (                        group and capture to \1:
      # ------------------------------------------------------------------------
      #     .*?                      any character except \n (0 or more times
      #                              (matching the least amount possible))
      # ------------------------------------------------------------------------
      #     (?=                      look ahead to see if there is:
      # ------------------------------------------------------------------------
      #       (?<!                     look behind to see if there is not:
      # ------------------------------------------------------------------------
      #         \?                       '?'
      # ------------------------------------------------------------------------
      #       )                        end of look-behind
      # ------------------------------------------------------------------------
      #       [:+']                    any character of: ':', '+', '''
      # ------------------------------------------------------------------------
      #     )                        end of look-ahead
      # ------------------------------------------------------------------------
      #   )                        end of \1
      ELEMENT_REGEX           = /(.*?(?=(?<!\?)[:+']))/

      # Binary Elements may contain unescaped delimiters. Thus they are not
      # terminated by regular delimiters. But their content is preceeded with
      # its length surrounded by '@'s. e.g.:
      #
      # '@6@mydata' or '@12@mydatamydata'
      #
      # The BINARY_ELEMENT_LENGTH_REGEx matches only the length.
      BINARY_ELEMENT_LENGTH_REGEX = /@(\d+)@/

      def self.parse(string)
        new(string).parse
      end

      def initialize(string)
        @scanner = StringScanner.new(string)
        @segments = []
        add_segment
        add_element_group
      end

      def parse
        parse_element
        while scanner.rest_size > 1
          parse_delimiter
          parse_element
        end
        segments
      end

      private

      def parse_regular_element
        str = scanner.scan(ELEMENT_REGEX)
        current_element_group << str.gsub('??', '?').gsub('?:', ':').gsub("?'", "'").gsub('?+', '+')
      end

      def parse_element
        binary_element_ahead? ? parse_binary_element : parse_regular_element
      end

      def parse_delimiter
        delimiter = scanner.getch
        return if scanner.eos?
        if delimiter == ELEMENT_GROUP_DELIMITER
          add_element_group
        elsif delimiter == SEGMENT_DELIMITER
          add_segment
          add_element_group
        end
      end

      def parse_binary_element
        scanner.scan(BINARY_ELEMENT_LENGTH_REGEX)
        binary = scanner.rest.byteslice(0, scanner[1].to_i)
        scanner.pos = scanner.pos + scanner[1].to_i
        current_element_group << binary
      end

      def binary_element_ahead?
        scanner.peek(1) == '@' && scanner.check(BINARY_ELEMENT_LENGTH_REGEX)
      end

      def add_segment
        segments << []
      end

      def add_element_group
        current_segment << []
      end

      def current_segment
        segments.last
      end

      def current_element_group
        current_segment.last
      end
    end
  end
end
