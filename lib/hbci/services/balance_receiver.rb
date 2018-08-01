# frozen_string_literal: true

module Hbci
  module Services
    class BalanceReceiver < BaseReceiver
      def perform
        request_message = MessageFactory.build(connector, dialog) do |hnvsd|
          hnvsd.add_segment(build_hksal)
        end
        request_message.compile

        @response = Response.new(connector.post(request_message))

        raise @response.to_s unless request_successful?

        @response.find('HNVSD').find('HISAL').booked_amount
      end

      private

      def request_successful?
        hirmg = @response.find('HIRMG')
        return false if hirmg && hirmg.ret_val_1.code[0].to_i == 9

        hnvsd = @response.find('HNVSD')
        hirmg = hnvsd.find('HIRMG')
        return false if hirmg && hirmg.ret_val_1.code[0].to_i == 9

        true
      end

      def build_hksal
        case version
        when 4 then build_hksal_v4
        when 6 then build_hksal_v6
        when 7 then build_hksal_v7
        end
      end

      def build_hksal_v4
        hksal = Segments::HKSALv4.new
        hksal.account.code   = iban.extended_data.bank_code
        hksal.account.number = iban.extended_data.account_number
        hksal
      end

      def build_hksal_v6
        hksal = Segments::HKSALv6.new
        hksal.account.number = iban.extended_data.account_number
        hksal.account.kik_blz = iban.extended_data.bank_code
        hksal
      end

      def build_hksal_v7
        hksal = Segments::HKSALv7.new
        hksal.account.iban        = iban.to_s
        hksal.account.bic         = iban.extended_data.bic
        hksal.account.kik_blz     = iban.extended_data.bank_code
        hksal.account.kik_country = 280
        hksal.account.number      = iban.extended_data.account_number
        hksal
      end

      def supported_versions
        dialog.response.find('HNVSD').find_all('HISALS').map { |x| x.head.version.to_i }
      end
    end
  end
end
