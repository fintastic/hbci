# frozen_string_literal: true

require_relative '../lib/hbci'
require_relative 'credentials'

Hbci::Connector.open(@credentials) do |connector|
  Hbci::Dialog.open(connector, system_id: @options[:system_id]) do |dialog|
    accounts = Hbci::Services::AccountsReceiver.new(dialog).perform
    accounts.each do |account|
      puts account
    end
  end
end
