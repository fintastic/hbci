# frozen_string_literal: true

require 'singleton'

module Hbci
  class Connector
    include Singleton

    attr_accessor :message_number
    attr_reader :credentials

    def initialize
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

    def post(request_message)
      req = HTTParty.post(@credentials.url, body: request_message.to_base64)
      @message_number += 1
      raise "Error in https communication with bank: #{req.response.inspect}" unless req.success?
      Base64.decode64(req.response.body)
    end
  end
end
