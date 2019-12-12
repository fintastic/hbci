module HbciNg
  module Services
    class BaseReceiver < Base
      attr_reader :response

      def initialize(connector)
        @now = Time.now
        @connector = connector
        @security_reference = generate_security_reference.to_s

        @hnvsd_data_block = Message.new(hnvsd[2].to_s.sub(/@[0-9]+@/, ''))
      end

      def perform
        HbciNg.logger.info("Start #{self.class}")
        @response = HbciNg::Response.new(@connector.post(hbci_message))
        HbciNg.logger.info("Finish #{self.class}")
        @response
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

      def hnvsd
        @connector.session_service_response.find_segments('HNVSD').first
      end

      def hnhbk
        @connector.dialog_service_response.find_segments('HNHBK').first
      end

      def hikazs
        @hnvsd_data_block.find_segments('HIKAZS')
      end

      # Nachrichtenkopf version 3
      def build_hnhbk_version_3(posistion)
        Segment.new.head('HNHBK', posistion, 3).init(nil, 300, hnhbk[4].to_s, @connector.message_number)
      end

      # Verschlüsselungskopf version 3
      def build_hnvsk_version_3(posistion)
        hnvsk = Segment.new
        hnvsk.head('HNVSK', posistion, 3)
        hnvsk.init(['PIN', 2], 998, 1, [1, nil, 0], [1, nil, nil], [2, 2, 13, '@5@NOKEY', 5, 1], [280, nil, nil, 'V', 1, 1], 0)
        hnvsk[5][3] = @hnvsd_data_block.find_segments('HISYN').first[2]
        hnvsk[6][2] = @now.strftime('%Y%m%d')
        hnvsk[6][3] = @now.strftime('%H%m%S')
        hnvsk[8][2] = @connector.iban.extended_data.bank_code
        hnvsk[8][3] = HbciNg.config.user_id
        hnvsk
      end

      # Signaturkopf version 4
      def build_hnshk_version_4(posistion)
        hnshk = Segment.new.head('HNSHK', posistion, 4)
        hnshk.init(['PIN', 2], nil, nil, 1, 1, [1, nil, 0], 2, [1, nil, nil], [1, 999, 1], [6, 10, 16], [280, nil, nil, 'S', 0, 0])
        hnshk[3] = @hnvsd_data_block.find_segments('HITANS').first[5][4]
        hnshk[4] = @security_reference
        hnshk[7][3] = @hnvsd_data_block.find_segments('HISYN').first[2]
        hnshk[9][2] = @now.strftime('%Y%m%d')
        hnshk[9][3] = @now.strftime('%H%m%S')
        hnshk[12][2] = @connector.iban.extended_data.bank_code
        hnshk[12][3] = HbciNg.config.user_id
        hnshk
      end
    end
  end
end
