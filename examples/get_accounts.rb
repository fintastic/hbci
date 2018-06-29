require_relative '../lib/bankster/hbci'
require_relative 'credentials'

Bankster::Hbci::Dialog.open(@credentials) do |dialog|
  accounts = Bankster::Hbci::Services::AccountsReceiver.new(dialog).perform
  accounts.each do |account|
    puts account
  end
end
