module Bankster
  module Hbci
    class Response < Message
      attr_reader :dialog
      attr_reader :sec_ref

      attr_accessor :head
      attr_accessor :sig_head
      attr_accessor :enc_head
      attr_accessor :encrypted_payload
      attr_accessor :sig_tail
      attr_accessor :tail
      attr_accessor :raw

      attr_accessor :payload

      def success?
        true
      end


      def self.parse(dialog:, raw_response:)
        # byebug
        raw_response = raw_response.force_encoding('iso-8859-1').encode('utf-8')
        parsing_tree = Parser.new.parse(raw_response)
        raw_segments = Transformer.new.apply(parsing_tree)
        regex = /((?-:HNVSD:\d{1,3}:\d{1,3}.*\'\')|(?-:[A-Z]{4,6}:\d{1,3}:\d{1,3}.*?\'))/
        message = self.new(dialog: dialog)
        message.raw = raw_response


        raw_segments.each do |raw_segment|
          segment = SegmentParser.parse(raw_segment)

          next unless segment.respond_to?(:head)

          case segment.head.type
            when 'HNHBK' then message.head = segment
            when 'HNVSK' then message.enc_head = segment
            when 'HNSHK' then message.sig_head = segment
            when 'HNVSD' then message.encrypted_payload = segment
            when 'HNSHA' then message.sig_tail = segment
            when 'HNHBS' then message.tail = segment
          end
        end

        if message.encrypted_payload
          raw_payload = message.encrypted_payload.to_s.split('@',3)[2]
          # TODO: remove the following line. That last apostrophe should not be here. 
          raw_payload.chomp!('\'')

          parsing_tree = Parser.new.parse(raw_payload)
          raw_segments = Transformer.new.apply(parsing_tree)

          message.payload = raw_segments.map do |raw_segment|
            SegmentParser.parse(raw_segment)
          end

        end
        message
      end
    end
  end
end
