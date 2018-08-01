# frozen_string_literal: true

module Hbci
  module Services
    class TransactionsReceiver < BaseReceiver
      attr_reader :next_attach

      def perform(start_date, end_date)
        @start_date = start_date
        @end_date = end_date

        transactions = []
        loop do
          request_message = MessageFactory.build(connector, dialog) do |hnvsd|
            hnvsd.add_segment(build_hkkaz)
          end
          request_message.compile

          @response = Response.new(connector.post(request_message))

          raise @response.to_s unless request_successful?

          hikaz = @response.find('HNVSD').find('HIKAZ')
          transactions.concat(parse_transactions(hikaz.booked)) if hikaz

          break if @response.find('HNVSD').find('HIRMS').ret_val_1.code != '3040'

          @next_attach = @response.find('HNVSD').find('HIRMS').ret_val_1.parm
        end
        transactions
      end

      private

      def build_hkkaz
        case version
        when 6 then build_hkkaz_v6
        when 7 then build_hkkaz_v7
        end
      end

      def build_hkkaz_v6
        hkkaz = Segments::HKKAZv6.new
        hkkaz.account.number      = iban.extended_data.account_number
        hkkaz.account.kik_blz     = iban.extended_data.bank_code
        hkkaz.account.kik_country = 280
        hkkaz.from                = @start_date.strftime('%Y%m%d')
        hkkaz.to                  = @end_date.strftime('%Y%m%d')
        hkkaz.attach              = next_attach
        hkkaz
      end

      def build_hkkaz_v7
        hkkaz = Segments::HKKAZv7.new
        hkkaz.account.iban        = iban.to_s
        hkkaz.account.bic         = iban.extended_data.bic
        hkkaz.account.number      = iban.extended_data.account_number
        hkkaz.account.kik_blz     = iban.extended_data.bank_code
        hkkaz.account.kik_country = 280
        hkkaz.from                = @start_date.strftime('%Y%m%d')
        hkkaz.to                  = @end_date.strftime('%Y%m%d')
        hkkaz.attach              = next_attach
        hkkaz
      end

      def parse_transactions(mt940)
        Cmxl.parse(mt940.force_encoding('ISO-8859-1').encode('UTF-8')).flat_map(&:transactions).map(&:to_h)
      end

      def supported_versions
        dialog.response.find('HNVSD').find_all('HIKAZS').map { |x| x.head.version.to_i }
      end
    end
  end
end
