module Bankster
  module Hbci
    class Request < Message
      attr_reader :dialog
      attr_reader :sec_ref


      def head
        Segments::HNHBKv3.build(dialog: dialog, message: self)
      end

      def enc_head
        Segments::HNVSKv3.build(dialog: dialog)
      end

      def sig_head
        Segments::HNSHKv4.build(dialog: dialog, message: self)
      end

      def encrypted_payload
        Segments::HNVSDv1.build(message: self)
      end

      def sig_tail
        Segments::HNSHAv2.build(dialog: dialog, message: self)
      end

      def tail
        Segments::HNHBSv1.build(dialog: dialog, message: self)
      end
    end
  end
end
