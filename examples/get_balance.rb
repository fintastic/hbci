# frozen_string_literal: true

require_relative '../lib/hbci'
require_relative 'credentials'

Hbci::Connector.open(@iban) do |connector|
  session_service = Hbci::Services::Session.new(connector)
  session_service.perform

  connector.session_service_response = session_service.response

  dialog_service = Hbci::Services::Dialog.new(connector)
  dialog_service.perform

  connector.dialog_service_response = dialog_service.response

  balance_receiver = Hbci::Services::BalanceReceiver.new(connector)
  balance_receiver.perform
end

