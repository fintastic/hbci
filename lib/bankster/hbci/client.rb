module Bankster
  module Hbci
    class Client
      attr_reader :credentials

      def initialize(credentials)
        raise ArgumentError, "#{self.class.name}#initialize expects a Bankster::BankCredentials::Hbci object" unless credentials.is_a?(Bankster::BankCredentials::Hbci)
        @credentials = credentials
        credentials.validate!
      end

      def accounts
        Services::AccountsReceiver.perform(credentials)
      end

      def transactions(account_number, start_date, end_date, version = 6)
        Services::TransactionsReceiver.perform(credentials, account_number, start_date, end_date, version)
      end

      def balance(account_number)
        Services::BalanceReceiver.perform(credentials, account_number)
      end
    end
  end
end
