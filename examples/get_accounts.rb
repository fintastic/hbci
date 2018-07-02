# frozen_string_literal: true

require_relative '../lib/hbci'
require_relative 'credentials'

Hbci::Dialog.open(@credentials) do |dialog|
  accounts = Hbci::Services::AccountsReceiver.new(dialog).perform
  accounts.each do |account|
    puts account
  end
end
