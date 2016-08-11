module Bankster
  module Hbci
    class Message
      attr_reader :dialog
      attr_reader :sec_ref

      def payload_index_of(segment)
        @payload.index(segment) || 0
      end

      def raw
        enveloped.join('')
      end

      def enveloped
        [head, enc_head, encrypted_payload, tail]
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
        @sec_ref = self.class.generate_security_reference
        @dialog = dialog
        @payload = []
      end

      def self.generate_security_reference
        rand(1..23) * 999_999 + 1_000_000
      end

      def add_payload(segment)
        @payload << segment
      end
    end
  end
end
