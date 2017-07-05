module Bankster
  module Hbci
    module Services
      class AccountsReceiver
        attr_reader :credentials

        def self.perform(*args)
          new(*args).perform
        end

        def initialize(credentials)
          @credentials = credentials
        end

        def perform
          dialog = Dialog.new(credentials)
          dialog.initiate
          dialog.finish
          dialog.accounts.map do |eg|
            { account_number: eg.number, bank_code: eg.kik_blz }
          end
        end
      end
    end
  end
end
