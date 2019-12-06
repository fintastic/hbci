module HbciNg
  module Services
    class BalanceReceiver
      attr_reader :response

      def initialize(connector)
        @now = Time.now
        @connector = connector
        @security_reference = generate_security_reference.to_s

        @hnvsd = @connector.session_service_response.find_segments('HNVSD').first
        @hnvsd_data_block = Message.new(@hnvsd[2].to_s.sub(/@[0-9]+@/, ''))

        @hnhbk = @connector.dialog_service_response.find_segments('HNHBK').first
      end

      def perform
        Hbci.logger.info('Start balance')

        @response = HbciNg::Response.new(@connector.post(hbci_message))

        Hbci.logger.info('Finish balance')
      end

      def hbci_message
        # Nachrichtenkopf
        hnhbk = Segment.new
        hnhbk.head('HNHBK', 1, 3)
        hnhbk.init(nil, 300, @hnhbk[4].to_s, @connector.message_number)

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
        hnvsd.add_data_block(2, encrypted_hbci_message)

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

      def encrypted_hbci_message
        # Signaturkopf
        hnshk = Segment.new
        hnshk.head('HNSHK', 2,4)
        hnshk.init(['PIN', 2], nil, nil, 1, 1, [1, nil, 0], 2, [1, nil, nil], [1, 999, 1], [6, 10, 16], [280, nil, nil, 'S', 0, 0])
        hnshk[3] = @hnvsd_data_block.find_segments('HITANS').first[5][4]
        hnshk[4] = @security_reference
        hnshk[7][3] = @hnvsd_data_block.find_segments('HISYN').first[2]
        hnshk[9][2] = @now.strftime('%Y%m%d')
        hnshk[9][3] = @now.strftime('%H%m%S')
        hnshk[12][2] = @connector.iban.extended_data.bank_code
        hnshk[12][3] = HbciNg.config.user_id

        hksal = Segment.new
        hksal.head('HKSAL', 3, 7)
        hksal.init([@connector.iban.to_s, @connector.iban.extended_data.bic, @connector.iban.extended_data.account_number, nil, 280, @connector.iban.extended_data.bank_code], 'N')

        # Zwei-Schritt-TAN-Einreichung
        #hktan = Segment.new
        #hktan.head('HKTAN', 5,6)
        #hktan.init(4, 'HKIDN')

        # Signaturabschluss
        hnsha = Segment.new
        hnsha.head('HNSHA', 4,2)
        hnsha.init(nil, nil, nil)
        hnsha[2] = @security_reference
        hnsha[4] = HbciNg.config.pin

        encrypted_message = Message.new
        encrypted_message[1] = hnshk
        #encrypted_message[2] = hkidn
        #encrypted_message[3] = hkvvb
        #encrypted_message[4] = hktan
        encrypted_message[2] = hksal
        encrypted_message[3] = hnsha
        encrypted_message
      end

      def generate_security_reference
        rand(1..23) * 999_999 + 1_000_000
      end
    end
  end
end
