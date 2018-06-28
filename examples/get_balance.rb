require_relative '../lib/hbci'
require_relative 'credentials'

Hbci::Dialog.open(@credentials) do |dialog|
  puts Hbci::Services::BalanceReceiver.new(dialog, @iban).perform
end
