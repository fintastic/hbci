module Bankster
  module Hbci
    module Services
      class TransactionsReceiver
        attr_reader :credentials
        attr_reader :account_number
        attr_reader :start_date
        attr_reader :end_date
        attr_reader :version
        attr_reader :next_attach

        def self.perform(*args)
          new(*args).perform
        end

        def initialize(credentials, account_number, start_date, end_date, version = 6)
          @credentials = credentials
          @account_number = account_number
          @start_date = start_date
          @end_date = end_date
          @version = version
        end

        def perform
          @dialog = Dialog.new(@credentials)
          @dialog.initiate

          transactions = receive_transactions

          @dialog.finish

          transactions
        end

        private

        def receive_transactions
          transactions = []

          loop do
            messenger = Messenger.new(dialog: @dialog)
            messenger.add_request_payload(build_request_segment)
            messenger.request!

            response_segment = messenger.response.payload.find { |seg| seg.head.type == 'HIKAZ' }

            transactions.concat(parse_transactions(response_segment.booked))

            break unless messenger.response.payload.find { |seg| seg.head.type == 'HIRMS' }[1][0] == '3040'

            @next_attach = messenger.response.payload.find { |seg| seg.head.type == 'HIRMS' }[1][3]
          end

          transactions
        end

        def build_request_segment
          if version == 6
            segment = Segments::HKKAZv6.build(dialog: @dialog)
          elsif version == 7
            segment = Segments::HKKAZv7.build(dialog: @dialog)

            segment.account.iban        = calculate_iban(credentials.bank_code, account_number)
            segment.account.bic         = calculate_bic(credentials.bank_code)
          end

          segment.account.number      = account_number
          segment.account.kik_blz     = credentials.bank_code
          segment.account.kik_country = 280

          segment.from                = start_date.strftime('%Y%m%d')
          segment.to                  = end_date.strftime('%Y%m%d')
          segment.attach              = next_attach
          segment
        end

        def calculate_iban(bank_code, account_number)
          Ibanizator.new.calculate_iban(country_code: :de, bank_code: bank_code, account_number: account_number)
        end

        def calculate_bic(bank_code)
          Ibanizator.bank_db.bank_by_bank_code(bank_code).bic
        end

        def parse_transactions(mt940)
          Cmxl.parse(mt940.force_encoding('ISO-8859-1').encode('UTF-8')).flat_map(&:transactions).map(&:to_h)
        end
      end
    end
  end
end
