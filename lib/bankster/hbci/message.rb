module Bankster
  module Hbci
    class Message
      attr_reader :dialog
      attr_reader :sec_ref

      def payload_index_of(segment)
        @payload.index(segment) || 0
      end

      def enc_head
        Segments::HNVSKv3.build(dialog: dialog)
      end

      def sig_head
        Segments::HNSHKv4.build(dialog: dialog, message: self)
      end

      def sig_tail
        Segments::HNSHAv2.build(dialog: dialog, message: self)
      end

      def head
        Segments::HNHBKv3.build(dialog: dialog, message: self)
      end

      def tail
        Segments::HNHBSv1.build(dialog: dialog, message: self)
      end

      def raw
        enveloped.join('')
      end

      def enveloped
        [head, enc_head, encrypted_payload, tail]
      end

      def encrypted_payload
        Segments::HNVSDv1.build(message: self)
      end

      def signed_payload
        [sig_head, payload, sig_tail].flatten
      end

      def payload
        @payload.map do |segment|
          segment.message = self
          segment
        end
      end

      def initialize(dialog:)
        @sec_ref = rand(1..23) * 999999 + 1000000

        @dialog = dialog
        @payload = []
      end

      def add_payload(segment)
        @payload << segment
      end

      def inspect_payload
        string = "Message Payload #{payload.count} segments: \n"
        payload.each { |segment| string << "#{segment.to_s} \n" }
        string
      end
    end
  end
end
