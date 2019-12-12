module HbciNg
  module Services
    class Session < Base
      def perform
        HbciNg.logger.info('Start initiating FinTS/HBCI session')

        @response = HbciNg::Response.new(@connector.post(hbci_message, false))

        HbciNg.logger.info('Finish initiating FinTS/HBCI session')

        @response
      end

      private

      # Identifikation version 2
      def build_hkidn_version_2(position)
        hkidn = Segment.new.head('HKIDN', position, 2)
        hkidn.init([280, nil], nil, 0, 1)
        hkidn[2][2] = @connector.iban.extended_data.bank_code
        hkidn[3] = HbciNg.config.user_id
        hkidn
      end

      #  Verarbeitungsvorbereitung version 3
      def build_hkvvb_version_3(position)
        hkvvb = Segment.new.head('HKVVB', position,3)
        hkvvb.init(0, 0, 1, nil, '0.3.5')
        hkvvb[5] = HbciNg.config.product_name
        hkvvb
      end

      # Synchronisierung version 3
      def build_hksyn_version_3(position)
        hksyn = Segment.new.head('HKSYN', position,3)
        hksyn.init(0)
        hksyn
      end

      def hnvsd_data
        message = Message.new
        message[1] = build_hnshk_version_4(2)
        message[2] = build_hkidn_version_2(3)
        message[3] = build_hkvvb_version_3(4)
        message[4] = build_hksyn_version_3(5)
        message[5] = build_hnsha_version_2(6)
        message
      end
    end
  end
end
