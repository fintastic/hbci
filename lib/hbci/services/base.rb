module Hbci
  module Services
    class Base
      attr_reader :response

      def initialize(connector)
        @now = Time.now
        @connector = connector
        @security_reference = generate_security_reference.to_s
      end

      def perform
        raise 'overwrite me'
      end

      def hbci_message
        hbci_message = Message.new
        hbci_message[1] = build_hnhbk_version_3(1)
        hbci_message[2] = build_hnvsk_version_3(998)
        hbci_message[3] = build_hnvsd_version_1(999)
        hbci_message[4] = build_hnhbs_version_1(7)

        hbci_message[1][2] = hbci_message.to_s.size.to_s.rjust(12, '0')

        hbci_message
      end

      private

      def check_response_status!
        @response.hbci.find_segments('HIRMG').each do |segment|
          raise Hbci::Error, 'Initialization failed' if segment[2][1].to_i > 9000
        end

        @response.hnvsd_data_block.find_segments('HIRMG').each do |segment|
          raise Hbci::Error, 'Initialization failed' if segment[2][1].to_i > 9000
        end
      end

      # Nachrichtenkopf version 3
      def build_hnhbk_version_3(posistion)
        Segment.new.head('HNHBK', posistion, 3).init(nil, 300, 0, @connector.message_number)
      end

      # Verschlüsselungskopf version 3
      def build_hnvsk_version_3(posistion)
        hnvsk = Segment.new
        hnvsk.head('HNVSK', posistion, 3)
        hnvsk.init(['PIN', 1], 998, 1, [1, nil, 0], [1, nil, nil], [2, 2, 13, '@5@NOKEY', 5, 1], [280, nil, nil, 'V', 1, 1], 0)
        hnvsk[6][2] = @now.strftime('%Y%m%d')
        hnvsk[6][3] = @now.strftime('%H%m%S')
        hnvsk[8][2] = @connector.iban.extended_data.bank_code
        hnvsk[8][3] = Hbci.config.user_id
        hnvsk
      end

      # Verschlüsselte Daten version 1
      def build_hnvsd_version_1(posistion)
        hnvsd = Segment.new
        hnvsd.head('HNVSD', posistion, 1)
        hnvsd.add_data_block(2, hnvsd_data)
        hnvsd
      end

      # Signaturabschluss version 1
      def build_hnhbs_version_1(posistion)
        hnhbs = Segment.new
        hnhbs.head('HNHBS', posistion, 1)
        hnhbs.init(1)
        hnhbs
      end

      # Signaturkopf version 4
      def build_hnshk_version_4(posistion)
        hnshk = Segment.new.head('HNSHK', posistion, 4)
        hnshk.init(['PIN', 1], 999, nil, 1, 1, [1, nil, 0], 2, [1, nil, nil], [1, 999, 1], [6, 10, 16], [280, nil, nil, 'S', 0, 0])
        hnshk[4] = @security_reference
        hnshk[9][2] = @now.strftime('%Y%m%d')
        hnshk[9][3] = @now.strftime('%H%m%S')
        hnshk[12][2] = @connector.iban.extended_data.bank_code
        hnshk[12][3] = Hbci.config.user_id
        hnshk
      end

      # Zwei-Schritt-TAN-Einreichung version 6
      def build_hktan_version_6(posistion)
        Segment.new.head('HKTAN', posistion, 6).init(4, 'HKKAZ')
      end

      # Signaturabschluss version 2
      def build_hnsha_version_2(posistion)
        Segment.new.head('HNSHA', posistion, 2).init(@security_reference, nil, Hbci.config.pin)
      end

      def generate_security_reference
        rand(1..23) * 999_999 + 1_000_000
      end
    end
  end
end
