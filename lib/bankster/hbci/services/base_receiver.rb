module Bankster
  module Hbci
    module Services
      class BaseReceiver
        attr_reader :dialog
        attr_reader :account_number

        def initialize(dialog, account_number, version = nil)
          @dialog = dialog
          @account_number = account_number
          @version = version

          raise "The version #{@version} is not supported" if version && !supported_versions.include?(@version)
          raise "The account_number #{account_number} is not accessible for the given credentials" unless dialog.accounts.map(&:number).include?(account_number)
        end

        def perform
          raise NotImplementedError, "#{self.class.name}#perform is an abstract method."
        end

        private

        def version
          @version ||= supported_versions.max
        end

        def supported_versions
          raise NotImplementedError, "#{self.class.name}#supported_versions is an abstract method."
        end

        def calculate_iban(bank_code, account_number)
          Ibanizator.new.calculate_iban(country_code: :de, bank_code: bank_code, account_number: account_number)
        end

        def calculate_bic(bank_code)
          Ibanizator.bank_db.bank_by_bank_code(bank_code).bic
        end
      end
    end
  end
end
