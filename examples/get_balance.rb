# frozen_string_literal: true

require_relative '../lib/hbci'
require_relative 'credentials'

Hbci::Dialog.open(system_id: @options[:system_id]) do |dialog|
  puts Hbci::Services::BalanceReceiver.new(dialog, @iban).perform
end
