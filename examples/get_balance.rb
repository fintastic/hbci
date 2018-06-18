require_relative '../lib/bankster/hbci'
require_relative 'credentials'

Bankster::Hbci::Dialog.open(@credentials) do |dialog|
  puts Bankster::Hbci::Services::BalanceReceiver.new(dialog, @account_number).perform
end

