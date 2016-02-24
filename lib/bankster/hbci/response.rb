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
        raw_segments = Parser.parse(raw_response.force_encoding('iso-8859-1'))

        message = self.new(dialog: dialog)

        message.raw = raw_response


        raw_segments.each do |raw_segment|
          segment = Bankster::Hbci::SegmentFactory.build(raw_segment)

          next unless segment.respond_to?(:head)

          case segment.head.type
            when 'HNHBK' then message.head              = segment
            when 'HNVSK' then message.enc_head          = segment
            when 'HNSHK' then message.sig_head          = segment
            when 'HNVSD' then message.encrypted_payload = segment
            when 'HNSHA' then message.sig_tail          = segment
            when 'HNHBS' then message.tail              = segment
          end
        end

        if message.encrypted_payload
          raw_payload_segments = Parser.parse(message.encrypted_payload.content)

          message.payload = raw_payload_segments.map do |raw_payload_segment|
            Bankster::Hbci::SegmentFactory.build(raw_payload_segment)
          end
        end
        message
      end
    end
  end
end
