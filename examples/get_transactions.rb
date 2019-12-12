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

  transactions_receiver = HbciNg::Services::TransactionsReceiver.new(connector, Time.now, Time.now)
  response = transactions_receiver.perform

  hnvsd = HbciNg::Message.new(response.to_s).find_segments('HNVSD').first
  hnvsd_data_block = HbciNg::Message.new(hnvsd[2].to_s.sub(/@[0-9]+@/, ''))

  hikaz = hnvsd_data_block.find_segments('HIKAZ').first
  hikaz_data_block = HbciNg::Message.new(hikaz[2].to_s.sub(/@[0-9]+@/, ''))

  statements = Cmxl.parse(hikaz_data_block[1].to_s.delete_suffix("'").force_encoding('ISO-8859-1').encode('UTF-8'))
  statements.each do |statement|
    puts statement.transactions.inspect
  end
end
