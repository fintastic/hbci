# frozen_string_literal: true

module Hbci
  module Services
    class AccountsReceiver
      attr_reader :dialog

      def initialize(dialog)
        @dialog = dialog
      end

      def perform
        dialog.accounts.map do |eg|
          { account_number: eg.number, bank_code: eg.kik_blz }
        end
      end
    end
  end
end
