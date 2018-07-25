# frozen_string_literal: true

module Hbci
  module Services
    class AccountsReceiver
      attr_reader :dialog

      def initialize(dialog)
        @dialog = dialog
      end

      def perform
        dialog.response.find('HNVSD').find_all('HIUPD').map do |hiupd|
          { account_number: hiupd.ktv.number, bank_code: hiupd.ktv.kik_blz }
        end
      end
    end
  end
end
