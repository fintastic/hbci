module Hbci
  module Services
    class Dialog < Base
      def perform
        Hbci.logger.info('Start initiating dialog')

        @response = Hbci::DialogResponse.new(@connector.post(hbci_message))

        check_response_status!

        Hbci.logger.info('Finish initiating dialog')

        @response
      end

      private

      # Verschlüsselungskopf version 3
      def build_hnvsk_version_3(posistion)
        hnvsk = Segment.new
        hnvsk.head('HNVSK', posistion, 3)
        hnvsk.init(['PIN', 2], 998, 1, [1, nil, 0], [1, nil, nil], [2, 2, 13, '@5@NOKEY', 5, 1], [280, nil, nil, 'V', 1, 1], 0)
        hnvsk[5][3] = @connector.session_service_response.hnvsd_data_block.find_segments('HISYN').first[2]
        hnvsk[6][2] = @now.strftime('%Y%m%d')
        hnvsk[6][3] = @now.strftime('%H%m%S')
        hnvsk[8][2] = @connector.iban.extended_data.bank_code
        hnvsk[8][3] = Hbci.config.user_id
        hnvsk
      end

      # Signaturkopf version 4
      def build_hnshk_version_4(posistion)
        hnshk = Segment.new.head('HNSHK', posistion, 4)
        hnshk.init(['PIN', 2], nil, nil, 1, 1, [1, nil, 0], 2, [1, nil, nil], [1, 999, 1], [6, 10, 16], [280, nil, nil, 'S', 0, 0])
        hnshk[3] = @connector.session_service_response.hnvsd_data_block.find_segments('HITANS').first[5][4]
        hnshk[4] = @security_reference
        hnshk[9][2] = @now.strftime('%Y%m%d')
        hnshk[9][3] = @now.strftime('%H%m%S')
        hnshk[12][2] = @connector.iban.extended_data.bank_code
        hnshk[12][3] = Hbci.config.user_id
        hnshk
      end

      # Identifikation version 2
      def build_hkidn_version_2(position)
        hkidn = Segment.new.head('HKIDN', position, 2)
        hkidn.init([280, nil], nil, 0, 1)
        hkidn[2][2] = @connector.iban.extended_data.bank_code
        hkidn[3] = Hbci.config.user_id
        hkidn
      end

      #  Verarbeitungsvorbereitung version 3
      def build_hkvvb_version_3(position)
        hkvvb = Segment.new.head('HKVVB', position,3)
        hkvvb.init(0, 0, 1, nil, '0.3.5')
        hkvvb[5] = Hbci.config.product_name
        hkvvb
      end

      # Zwei-Schritt-TANEinreichung version 6
      def build_hktan_version_6(position)
        Segment.new.head('HKTAN', position,6).init(4, 'HKIDN')
      end

      def hnvsd_data
        message = Message.new
        message[1] = build_hnshk_version_4(2)
        message[2] = build_hkidn_version_2(3)
        message[3] = build_hkvvb_version_3(4)
        message[4] = build_hktan_version_6(5)
        message[5] = build_hnsha_version_2(6)
        message
      end
    end
  end
end
