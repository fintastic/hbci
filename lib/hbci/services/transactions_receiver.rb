# frozen_string_literal: true

module Hbci
  module Services
    class TransactionsReceiver < BaseReceiver
      attr_reader :next_attach

      def perform(start_date, end_date)
        Hbci.logger.info("Start #{self.class} request")

        @start_date = start_date
        @end_date = end_date

        transactions = []
        loop do
          request_message = Message.new(connector, dialog)
          request_message.add_segment(Segments::HNHBKv3.new)
          request_message.add_segment(build_hnvsk)
          hnvsd = Segments::HNVSDv1.new do |s|
            s.add_segment(build_hnshk)
            s.add_segment(build_hkkaz)
            s.add_segment(build_hktan)
            s.add_segment(Segments::HNSHAv2.new)
          end
          request_message.add_segment(hnvsd)
          request_message.add_segment(Segments::HNHBSv1.new)
          request_message.compile

          @response = Response.new(connector.post(request_message))

          raise @response.to_s unless request_successful?

          hikaz = @response.find('HNVSD').find('HIKAZ')
          transactions.concat(parse_transactions(hikaz.booked)) if hikaz

          break if @response.find('HNVSD').find('HIRMS').ret_val_1.code != '3040'

          @next_attach = @response.find('HNVSD').find('HIRMS').ret_val_1.parm
        end

        Hbci.logger.info("Finish #{self.class} request")
        transactions
      end

      private

      def build_hnvsk
        hnvsk = Hbci::Segments::HNVSKv3.new
        hnvsk.security_profile.version = 2
        hnvsk
      end

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

      def build_hnshk
        hnshk = Hbci::Segments::HNSHKv4.new
        hnshk.tan_mechanism = dialog.security_function
        hnshk.security_profile.version = 2
        hnshk
      end

      def build_hktan
        hktan = Hbci::Segments::HKTANv6.new
        hktan.tan_mechanism = 4
        hktan.seg_id = 'HKKAZ'
        hktan
      end

      def parse_transactions(mt940)
        Cmxl.parse(mt940.force_encoding('ISO-8859-1').encode('UTF-8')).flat_map(&:transactions).map(&:to_h)
      end

      def supported_versions
        dialog.hikazs_versions
      end
    end
  end
end
