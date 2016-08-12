module Bankster
  module Hbci
    class Client
      attr_reader :credentials

      def initialize(credentials)
        unless credentials.is_a?(Bankster::BankCredentials::Hbci)
          raise ArgumentError, "#{self.class.name}#initialize expects a Bankster::BankCredentials::Hbci object"
        end
        @credentials = credentials
        credentials.validate!
      end

      def accounts
        dialog = Dialog.new(credentials)
        dialog.initiate
        dialog.finish
        dialog.accounts
      end

      def transactions(account_number, start_date, end_date, version = 6)
        Services::TransactionsReceiver.perform(credentials, account_number, start_date, end_date, version)
      end

      def balance(account_number)
        dialog = Dialog.new(credentials)
        dialog.initiate

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
