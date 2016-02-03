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
        regex = /((?-:HNVSD:\d{1,3}:\d{1,3}.*\'\')|(?-:[A-Z]{4,6}:\d{1,3}:\d{1,3}.*?\'))/
        message = self.new(dialog: dialog)
        message.raw = raw_response

        raw_response.scan(regex).each do |segment_matches|
          segment = SegmentParser.parse(segment_matches[0])

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
          raw_payload.chomp!('\'')

          message.payload = raw_payload.scan(regex).map do |segment_matches|
            segment = SegmentParser.parse(segment_matches[0])
          end

        end
        message
      end
    end
  end
end
