module HbciNg
  module Services
    class BalanceReceiver < BaseReceiver
      private

      # Saldenabfrage version 7
      def build_hksal_version_7(posistion)
        hksal = Segment.new
        hksal.head('HKSAL', posistion, 7)
        hksal.init([@connector.iban.to_s, @connector.iban.extended_data.bic, @connector.iban.extended_data.account_number, nil, 280, @connector.iban.extended_data.bank_code], 'N')
        hksal
      end

      # Saldenabfrage
      def build_hksal(posistion)
        version = hikazs.map { |s| s[1][3].to_i }.max
        case version
        when 7 then build_hksal_version_7(posistion)
        else
          raise "HKKAZ #{version} is not supported"
        end
      end

      def hnvsd_data
        message = Message.new
        message[1] = build_hnshk_version_4(2)
        message[2] = build_hksal(3)
        message[3] = build_hnsha_version_2(4)
        message
      end
    end
  end
end
