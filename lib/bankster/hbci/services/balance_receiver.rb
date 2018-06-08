module Bankster
  module Hbci
    module Services
      class BalanceReceiver
        attr_reader :credentials
        attr_reader :account_number

        def self.perform(*args)
          new(*args).perform
        end

        def initialize(credentials, account_number)
          @credentials = credentials
          @account_number = account_number
        end

        def perform
          dialog = Dialog.new(credentials)
          dialog.initiate

          raise "The account_number #{account_number} is not accessible for the given credentials" unless dialog.accounts.map(&:number).include?(account_number)

          messenger = Messenger.new(dialog: dialog)

          balance_request_segment = Segments::HKSALv4.build(dialog: @dialog)
          balance_request_segment.account.code = @credentials.bank_code
          balance_request_segment.account.number = account_number
          balance_request_segment.all_accounts = 'N'

          messenger.add_request_payload(balance_request_segment)
          messenger.request!

          balance = messenger.response.payload.select { |seg| seg.head.type == 'HISAL' }.first.booked_amount

          dialog.finish

          balance
        end
      end
    end
  end
end
