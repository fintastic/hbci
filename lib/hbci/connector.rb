# frozen_string_literal: true

module Hbci
  class Connector
    attr_accessor :message_number
    attr_reader :credentials

    def self.open(credentials)
      connector = new(credentials)
      yield connector
      connector.reset_message_number
    end

    def initialize(credentials)
      self.credentials = credentials
      reset_message_number
    end

    def credentials=(credentials)
      raise ArgumentError, "#{self.class.name}#initialize expects a BankCredentials::Hbci object" unless credentials.is_a?(BankCredentials::Hbci)

      credentials.validate!
      @credentials = credentials
    end

    def reset_message_number
      @message_number = 1
    end

    def post(request_message, count_messages = true)
      Hbci.logger.debug("Request: #{request_message}")
      req = HTTParty.post(@credentials.url, body: request_message.to_base64)
      @message_number += 1 if count_messages
      raise "Error in https communication with bank: #{req.response.inspect}" unless req.success?

      decode_response = Base64.decode64(req.response.body)
      Hbci.logger.debug("Response: #{decode_response}")
      decode_response
    end
  end
end
