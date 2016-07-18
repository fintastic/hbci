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

      def all_transactions(start_date, end_date)
        dialog.accounts.each_with_object({}) do |account, output|
          output[account.number] = transactions(account.number, start_date, end_date)
        end
      end

      def transactions(account_number, start_date, end_date, version = 6)
        messenger = Messenger.new(dialog: dialog)

        if version == 6
          transactions_request_segment = Segments::HKKAZv6.build(dialog: @dialog)
        elsif version == 7
          iban = Ibanizator.new.calculate_iban country_code: :de, bank_code: credentials.bank_code, account_number: account_number
          bic = Ibanizator.bank_db.bank_by_bank_code(credentials.bank_code).bic
          transactions_request_segment = Segments::HKKAZv7.build(dialog: @dialog)
          transactions_request_segment.account.iban        = iban
          transactions_request_segment.account.bic         = bic
        end

        transactions_request_segment.account.number      = account_number
        transactions_request_segment.account.kik_blz     = credentials.bank_code
        transactions_request_segment.account.kik_country = 280

        transactions_request_segment.all_accounts        = 'N'
        transactions_request_segment.from                = start_date.strftime('%Y%m%d')
        transactions_request_segment.to                  = end_date.strftime('%Y%m%d')

        messenger.add_request_payload(transactions_request_segment)
        messenger.request!

        transactions = []

        transaction_segment = messenger.response.payload.find { |seg| seg.head.type == 'HIKAZ' }
        response_code = messenger.response.payload.find { |seg| seg.head.type == 'HIRMS'  }[1][0]

        if transaction_segment
          transactions.push(*Cmxl.parse(transaction_segment.booked.force_encoding('ISO-8859-1').encode('UTF-8')).flat_map(&:transactions).map(&:to_h))
        end

        while messenger.response.payload.find { |seg| seg.head.type == 'HIRMS'   }[1][0] == "3040" && attach = messenger.response.payload.find { |seg| seg.head.type == 'HIRMS' }[1][3] do
          messenger = Messenger.new(dialog: dialog)
          transactions_request_segment.attach = attach
          messenger.add_request_payload(transactions_request_segment)
          messenger.request!
          transaction_segment = messenger.response.payload.find { |seg| seg.head.type == 'HIKAZ' }
          transactions.push(*Cmxl.parse(transaction_segment.booked.force_encoding('ISO-8859-1').encode('UTF-8')).flat_map(&:transactions).map(&:to_h))
        end
        transactions
      end

      def balance(account_number)
        messenger = Messenger.new(dialog: dialog)

        balance_request_segment = Segments::HKSALv4.build(dialog: @dialog)
        balance_request_segment.account.code = @credentials.bank_code
        balance_request_segment.account.number = account_number
        balance_request_segment.all_accounts = 'N'

        messenger.add_request_payload(balance_request_segment)
        messenger.request!

        messenger.response.payload.select do |seg|
          seg.head.type == 'HISAL'
        end.each_with_object({}) do |seg, output|
          output[seg.ktv.number] = seg.booked_amount
        end
      end

      def dump_messages
        puts 'Messages:'
        dialog.sent_messages.each_with_index do |m, i|
          puts
          puts "Sent message #{i}"
          puts m.request.raw
          puts
          next unless m.response
          puts "Received response #{i}"
          puts m.response.raw
        end
      end
    end
  end
end
