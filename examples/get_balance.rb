# frozen_string_literal: true

require_relative '../lib/hbci'
require_relative '../lib/hbci_ng'
require_relative 'credentials'

Hbci::Connector.open(@credentials) do |connector|
  session_service = HbciNg::Services::Session.new(connector)
  session_service.perform


  # Hbci::Dialog.open(connector, tan: @options[:tan]) do |dialog|
    # puts Hbci::Services::BalanceReceiver.new(connector, dialog, @iban).perform
  # end
end


