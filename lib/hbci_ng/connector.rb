# frozen_string_literal: true

module HbciNg
  class Connector
    BANK_LIST = File.join(File.dirname(__FILE__), '../../config/bank_list.json')

    attr_accessor :message_number
    attr_reader :iban

    def self.open(iban)
      connector = new(iban)
      yield connector
      connector.reset_message_number
    end

    def initialize(iban)
      @iban = Ibanizator.iban_from_string(iban)
      reset_message_number
    end

    def reset_message_number
      @message_number = 1
    end

    def url
      @url ||= bank['pinTanURL']
    end

    def post(request_message, count_messages = true)
      Hbci.logger.debug("Request: #{request_message}")
      req = HTTParty.post(url, body: request_message.to_base64)
      @message_number += 1 if count_messages
      raise "Error in https communication with bank: #{req.response.inspect}" unless req.success?

      decode_response = Base64.decode64(req.response.body)
      Hbci.logger.debug("Response: #{decode_response}")
      decode_response
    end

    private

    def bank
      bank = bank_list.find { |b| b['blz'] == @iban.extended_data.bank_code }
      raise Errors::Config, "Bank \"#{bank_code}\" not found in bank list" unless bank

      bank
    end

    def bank_list
      File.open(BANK_LIST, 'r') { |f| @bank_list = JSON.parse(f.read) } unless @bank_list
      raise Errors::Config, 'Bank list is empty' if @bank_list.empty?

      @bank_list
    rescue OpenURI::HTTPError
      raise Errors::Config, 'Bank list not loadable'
    end
  end
end
