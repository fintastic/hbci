module HbciNg
  module Services
    class TransactionsReceiver < BaseReceiver
      def initialize(connector, from, to)
        super(connector)

        @from = from.strftime('%Y%m%d')
        @to = to.strftime('%Y%m%d')
      end

      private

      def hikazs
        @hnvsd_data_block.find_segments('HIKAZS')
      end

      def build_hkkaz_version_7(position)
        hksal = Segment.new.head('HKKAZ', position, 7)
        hksal.init([@connector.iban.to_s, @connector.iban.extended_data.bic, @connector.iban.extended_data.account_number, nil, 280, @connector.iban.extended_data.bank_code], 'N', @from, @to)
        hksal
      end

      def build_hkkaz(position)
        version = hikazs.map { |s| s[1][3].to_i }.max
        case version
        when 7 then build_hkkaz_version_7(position)
        else
          raise "HKKAZ #{version} is not supported"
        end
      end

      def hnvsd_data
        message = Message.new
        message[1] = build_hnshk_version_4(2)
        message[2] = build_hkkaz(3)
        message[3] = build_hktan_version_6(4)
        message[4] = build_hnsha_version_2(5)
        message
      end
    end
  end
end
