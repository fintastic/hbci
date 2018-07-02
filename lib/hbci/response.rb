# frozen_string_literal: true

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
      response = new(dialog: dialog)

      raw_segments = Parser.parse(raw_response.force_encoding('iso-8859-1'))

      response.raw = raw_response

      raw_segments.each do |raw_segment|
        segment = Hbci::SegmentFactory.build(raw_segment)

        next unless segment.respond_to?(:head)

        case segment.head.type
        when 'HNHBK' then response.head              = segment
        when 'HNVSK' then response.enc_head          = segment
        when 'HNSHK' then response.sig_head          = segment
        when 'HNVSD' then response.encrypted_payload = segment
        when 'HNSHA' then response.sig_tail          = segment
        when 'HNHBS' then response.tail              = segment
        end
      end

      if response.encrypted_payload
        raw_payload_segments = Parser.parse(response.encrypted_payload.content)

        response.payload = raw_payload_segments.map do |raw_payload_segment|
          Hbci::SegmentFactory.build(raw_payload_segment)
        end
      end
      response
    end
  end
end
