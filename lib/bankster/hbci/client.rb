module Bankster
  module Hbci
    class Client
      attr_reader :credentials
      def initialize(credentials)
        @credentials  = credentials
        credentials.validate!
      end

      def balances(account_number)
        @dialog = Dialog.new(credentials)
        @dialog.initiate

        messenger = Messenger.new(dialog: @dialog)

        balance_request_segment = Segments::HKSALv4.build(dialog: @dialog)
        balance_request_segment.account.code = @dialog.credentials.bank_code
        balance_request_segment.account.number = account_number
        balance_request_segment.all_accounts = "J"

        messenger.add_request_payload(balance_request_segment)
        messenger.request!

        messenger.response.payload.select { |seg| 
          seg.head.type == "HISAL" 
        }.each_with_object({}) { |seg, output|
          output[seg.ktv.number] = seg.booked_amount
        }
      end

      def balance(account_number)
        received = balances(account_number)

        raise "could not receive balance for account #{account_number}" if received[account_number].nil?

        received[account_number]
      end
    end
  end
end
