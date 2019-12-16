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

  hnvsd = connector.dialog_service_response.hbci.find_segments('HNVSD').first
  hnvsd_data_block = Hbci::Message.new(hnvsd[2].to_s.sub(/@[0-9]+@/, ''))

  hnvsd_data_block.find_segments('HIUPD').each do |segment|
    account_number = segment[2][1]
    bank_code = segment[2][4]
    iban = segment[3]
    owner = segment[7]
    puts "#{account_number}, #{bank_code}, #{iban}, #{owner}"
  end
end
