module Bankster
  module Hbci
    class Client

      attr_reader :credentials

      def initialize(credentials)
        unless credentials.is_a?(Bankster::BankCredentials::Hbci)
          fail ArgumentError.new("#{self.class.name}#initialize expects a Bankster::BankCredentials::Hbci object") 
        end
        @credentials = credentials
        credentials.validate!
      end

      def dialog
        @dialog ||= Dialog.new(credentials)
        @dialog.initiate unless @dialog.initiated?
        @dialog
      end

      def all_balances
        dialog.accounts.each_with_object({}) do |account, output|
          output.merge!(balance(account.number))
        end
      end

      def all_transactions
        dialog.accounts.each_with_object({}) do |account, output|
          output[account.number] = transactions(account.number)
        end
      end

      def transactions(account_number)
        messenger = Messenger.new(dialog: dialog)

        transactions_request_segment = Segments::HKKAZv6.build(dialog: @dialog)
        transactions_request_segment.account.number = account_number
        transactions_request_segment.account.kik_blz = @credentials.bank_code
        transactions_request_segment.account.kik_country = 280
        transactions_request_segment.all_accounts = "N"
        transactions_request_segment.from = Date.new(2016,1,20).strftime('%Y%m%d')
        transactions_request_segment.to = Date.new(2016,2,20).strftime('%Y%m%d')

        messenger.add_request_payload(transactions_request_segment)
        messenger.request!

        mt940 = messenger.response.payload.select { |seg| 
          seg.head.type == "HIKAZ" 
        }.first.booked.split('@',3)[2]
        Cmxl.parse(mt940).first.transactions.map(&:to_h)
      end

      def balance(account_number)
        messenger = Messenger.new(dialog: dialog)

        balance_request_segment = Segments::HKSALv4.build(dialog: @dialog)
        balance_request_segment.account.code = @credentials.bank_code
        balance_request_segment.account.number = account_number
        balance_request_segment.all_accounts = "N"

        messenger.add_request_payload(balance_request_segment)
        messenger.request!

        messenger.response.payload.select { |seg| 
          seg.head.type == "HISAL" 
        }.each_with_object({}) { |seg, output|
          output[seg.ktv.number] = seg.booked_amount
        }
      end

      def dump_messages
        puts "Messages:"
        dialog.sent_messages.each_with_index do |m, i|
          puts
          puts "Sent message #{i}"
          puts m.request.raw
          puts
          return unless m.response
          puts "Received response #{i}"
          puts m.response.raw
        end
      end
    end
  end
end
