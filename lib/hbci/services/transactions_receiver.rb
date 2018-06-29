module Hbci
  module Services
    class TransactionsReceiver < BaseReceiver
      attr_reader :dialog
      attr_reader :account_number
      attr_reader :next_attach

      def perform(start_date, end_date)
        transactions = []

        loop do
          messenger = Messenger.new(dialog: @dialog)
          messenger.add_request_payload(build_request_segment(start_date, end_date))
          messenger.request!

          response_segment = messenger.response.payload.find { |seg| seg.head.type == 'HIKAZ' }

          transactions.concat(parse_transactions(response_segment.booked))

          break unless messenger.response.payload.find { |seg| seg.head.type == 'HIRMS' }[1][0] == '3040'

          @next_attach = messenger.response.payload.find { |seg| seg.head.type == 'HIRMS' }[1][3]
        end

        transactions
      end

      private

      def supported_versions
        @supported_versions ||= @dialog.hikazs.map { |x| x.head.version.to_i }
      end

      def build_request_segment(start_date, end_date)
        if version == 6
          segment = Segments::HKKAZv6.build(dialog: @dialog)
        elsif version == 7
          segment = Segments::HKKAZv7.build(dialog: @dialog)

          segment.account.iban        = iban.to_s
          segment.account.bic         = iban.extended_data.bic
        end

        segment.account.number      = iban.extended_data.account_number
        segment.account.kik_blz     = iban.extended_data.bank_code
        segment.account.kik_country = 280

        segment.from                = start_date.strftime('%Y%m%d')
        segment.to                  = end_date.strftime('%Y%m%d')
        segment.attach              = next_attach
        segment
      end

      def parse_transactions(mt940)
        Cmxl.parse(mt940.force_encoding('ISO-8859-1').encode('UTF-8')).flat_map(&:transactions).map(&:to_h)
      end
    end
  end
end
