# frozen_string_literal: true

require_relative '../lib/hbci'
require_relative 'credentials'

start_date = 3.day.ago
end_date = Time.now

Hbci::Dialog.open(system_id: @options[:system_id]) do |dialog|
  transactions = Hbci::Services::TransactionsReceiver.new(dialog, @iban, @hbci_version).perform(start_date, end_date)
  transactions.each do |transaction|
    puts transaction
  end
end

