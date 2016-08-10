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

      def accounts
        dialog = Dialog.new(credentials)
        dialog.initiate
        dialog.finish
        dialog.accounts
      end

      def transactions(account_number, start_date, end_date, version = 6)
        dialog = Dialog.new(credentials)
        dialog.initiate

        messenger = Messenger.new(dialog: dialog)

        if version == 6
          transactions_request_segment = Segments::HKKAZv6.build(dialog: dialog)
        elsif version == 7
          iban = Ibanizator.new.calculate_iban country_code: :de, bank_code: credentials.bank_code, account_number: account_number
          bic = Ibanizator.bank_db.bank_by_bank_code(credentials.bank_code).bic
          transactions_request_segment = Segments::HKKAZv7.build(dialog: dialog)
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

        dialog.finish

        transactions
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
