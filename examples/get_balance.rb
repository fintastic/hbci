# frozen_string_literal: true

require_relative '../lib/hbci_ng'
require_relative 'credentials'

HbciNg::Connector.open(@iban) do |connector|
  session_service = HbciNg::Services::Session.new(connector)
  session_service.perform

  connector.session_service_response = session_service.response

  dialog_service = HbciNg::Services::Dialog.new(connector)
  dialog_service.perform

  connector.dialog_service_response = dialog_service.response

  balance_receiver = HbciNg::Services::BalanceReceiver.new(connector)
  balance_receiver.perform
end


