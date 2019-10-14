# frozen_string_literal: true

module Hbci
  module Services
    class BalanceReceiver < BaseReceiver
      def perform
        Hbci.logger.info("Start #{self.class} request")
        
        request_message = Message.new(connector, dialog)
        request_message.add_segment(Segments::HNHBKv3.new)
        request_message.add_segment(build_hnvsk)
        hnvsd = Segments::HNVSDv1.new do |s|
          s.add_segment(build_hnshk)
          s.add_segment(build_hksal)
          s.add_segment(build_hktan) if dialog.tan
          s.add_segment(Segments::HNSHAv2.new)
        end
        request_message.add_segment(hnvsd)
        request_message.add_segment(Segments::HNHBSv1.new)
        request_message.compile

        @response = Response.new(connector.post(request_message))

        raise @response.to_s unless request_successful?

        Hbci.logger.info("Finish #{self.class} request")
        @response.find('HNVSD').find('HISAL').booked_amount
      end

      def supported_versions
        dialog.hisals_versions
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

      def build_hnvsk
        hnvsk = Hbci::Segments::HNVSKv3.new
        hnvsk.security_profile.version = 2
        hnvsk
      end

      def build_hksal
        case version
        when 4 then build_hksal_v4
        when 5 then build_hksal_v5
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

      def build_hksal_v5
        hksal = Segments::HKSALv5.new
        hksal.account.number = iban.extended_data.account_number
        hksal.account.kik_blz = iban.extended_data.bank_code
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

      def build_hnshk
        hnshk = Hbci::Segments::HNSHKv4.new
        hnshk.tan_mechanism = dialog.security_function
        hnshk.security_profile.version = 2
        hnshk
      end

      def build_hktan
        hktan = Hbci::Segments::HKTANv6.new
        hktan.tan_mechanism = 4
        hktan.seg_id = 'HKSAL'
        hktan
      end
    end
  end
end
