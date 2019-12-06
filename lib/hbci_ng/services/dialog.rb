module HbciNg
  module Services
    class Dialog
      def initialize(connector)
        @now = Time.now
        @connector = connector
        @security_reference = generate_security_reference.to_s

        @hnvsd = @connector.session_service_response.find_segments('HNVSD').first
        @hnvsd_data_block = Message.new(@hnvsd[2].to_s.sub(/@[0-9]+@/, ''))
      end

      def perform
        Hbci.logger.info('Start initiating dialog')

        @response = HbciNg::Response.new(@connector.post(hbci_message, false))

        Hbci.logger.info('Finish initiating dialog')
      end

      def hbci_message
        # Nachrichtenkopf
        hnhbk = Segment.new
        hnhbk.head('HNHBK', 1, 3)
        hnhbk.init(nil, 300, 0, @connector.message_number)

        # Verschlüsselungskopf
        hnvsk = Segment.new
        hnvsk.head('HNVSK', 998, 3)
        hnvsk.init(['PIN', 2], 998, 1, [1, nil, 0], [1, nil, nil], [2, 2, 13, '@5@NOKEY', 5, 1], [280, nil, nil, 'V', 1, 1], 0)
        hnvsk[5][3] = @hnvsd_data_block.find_segments('HISYN').first[2]

        hnvsk[6][2] = @now.strftime('%Y%m%d')
        hnvsk[6][3] = @now.strftime('%H%m%S')
        hnvsk[8][2] = @connector.iban.extended_data.bank_code
        hnvsk[8][3] = HbciNg.config.user_id

        # Verschlüsselte Daten
        hnvsd = Segment.new
        hnvsd.head('HNVSD', 999,1)
        hnvsd.add_data_block(2, encrypted_hbci__message)

        # Signaturabschluss
        hnhbs = Segment.new
        hnhbs.head('HNHBS', 7,1)
        hnhbs.init(1)

        hbci_message = Message.new
        hbci_message[1] = hnhbk
        hbci_message[2] = hnvsk
        hbci_message[3] = hnvsd
        hbci_message[4] = hnhbs

        hnhbk[2] = hbci_message.to_s.size.to_s.rjust(12, '0')

        hbci_message
      end

      private

      def encrypted_hbci__message
        # Signaturkopf
        hnshk = Segment.new
        hnshk.head('HNSHK', 2,4)
        hnshk.init(['PIN', 2], nil, nil, 1, 1, [1, nil, 0], 2, [1, nil, nil], [1, 999, 1], [6, 10, 16], [280, nil, nil, 'S', 0, 0])
        hnshk[3] = @hnvsd_data_block.find_segments('HITANS').first[5][4]
        hnshk[4] = @security_reference
        hnshk[9][2] = @now.strftime('%Y%m%d')
        hnshk[9][3] = @now.strftime('%H%m%S')
        hnshk[12][2] = @connector.iban.extended_data.bank_code
        hnshk[12][3] = HbciNg.config.user_id

        # Identifikation
        hkidn = Segment.new
        hkidn.head('HKIDN', 3,2)
        hkidn.init([280, nil], nil, 0, 1)
        hkidn[2][2] = @connector.iban.extended_data.bank_code
        hkidn[3] = HbciNg.config.user_id

        #  Verarbeitungsvorbereitung
        hkvvb = Segment.new
        hkvvb.head('HKVVB', 4,3)
        hkvvb.init(0, 0, 1, nil, '0.3.5')
        hkvvb[5] = HbciNg.config.product_name

        # Zwei-Schritt-TAN-Einreichung
        hktan = Segment.new
        hktan.head('HKTAN', 5,6)
        hktan.init(4, 'HKIDN')

        # Signaturabschluss
        hnsha = Segment.new
        hnsha.head('HNSHA', 6,2)
        hnsha.init(nil, nil, nil)
        hnsha[2] = @security_reference
        hnsha[4] = HbciNg.config.pin

        encrypted_message = Message.new
        encrypted_message[1] = hnshk
        encrypted_message[2] = hkidn
        encrypted_message[3] = hkvvb
        encrypted_message[4] = hktan
        encrypted_message[5] = hnsha
        encrypted_message
      end

      def generate_security_reference
        rand(1..23) * 999_999 + 1_000_000
      end
    end
  end
end
