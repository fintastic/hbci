# frozen_string_literal: true

require_relative '../lib/hbci'
require_relative 'credentials'

Hbci::Dialog.open(system_id: @options[:system_id]) do |dialog|
  accounts = Hbci::Services::AccountsReceiver.new(dialog).perform
  accounts.each do |account|
    puts account
  end
end
