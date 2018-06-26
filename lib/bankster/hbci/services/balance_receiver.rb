module Bankster
  module Hbci
    module Services
      class BalanceReceiver < BaseReceiver
        def perform
          messenger = Messenger.new(dialog: dialog)

          if version == 4
            segment = Segments::HKSALv4.build(dialog: dialog)
            segment.account.code = iban.extended_data.bank_code
          elsif version == 7
            segment = Segments::HKSALv7.build(dialog: dialog)
            segment.account.iban        = iban.to_s
            segment.account.bic         = iban.extended_data.bic
            segment.account.kik_blz     = iban.extended_data.bank_code
            segment.account.kik_country = 280
          end
          segment.account.number = iban.extended_data.account_number

          messenger.add_request_payload(segment)
          messenger.request!
          messenger.response.payload.select { |seg| seg.head.type == 'HISAL' }.first.booked_amount
        end

        private

        def supported_versions
          @supported_versions ||= @dialog.hisals.map { |x| x.head.version.to_i }
        end
      end
    end
  end
end
