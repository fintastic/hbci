require_relative '../lib/bankster/hbci'
require_relative 'credentials'

start_date = 3.day.ago
end_date = Time.now

Bankster::Hbci::Dialog.open(@credentials) do |dialog|
  transactions = Bankster::Hbci::Services::TransactionsReceiver.new(dialog, @iban, @hbci_version).perform(start_date, end_date)
  transactions.each do |transaction|
    puts transaction
  end
end
