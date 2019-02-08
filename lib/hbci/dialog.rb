# frozen_string_literal: true

module Hbci
  class Dialog
    attr_reader :id
    attr_reader :hbci_version
    attr_reader :system_id
    attr_reader :tan_mechanism
    attr_reader :response
    attr_reader :connector

    def self.open(connector, system_id: 0)
      dialog = Dialog.new(connector, system_id: system_id)
      dialog.initiate
      yield dialog
      dialog.finish
    end

    def initialize(connector, system_id: 0)
      @connector = connector
      @initiated = false
      @hbci_version = '3.0'
      @system_id = system_id
      @tan_mechanism = nil
      @id = 0
      @response = nil
    end

    def credentials
      @connector.credentials
    end

    def initiated?
      @initiated
    end

    def initiate
      request_message = MessageFactory.build(@connector, self) do |hnvsd|
        hnvsd.add_segment(Segments::HKIDNv2.new)
        hnvsd.add_segment(Segments::HKVVBv3.new)
      end
      request_message.compile

      @response = Response.new(@connector.post(request_message))

      raise DialogError.new('Initialization failed', @response.to_s) unless initialization_successful?

      @id            = @response.find('HNHBK').dialog_id
      @tan_mechanism = @response.find('HNVSD').find('HIRMS').allowed_tan_mechanism
      @initiated     = true
    end

    def finish
      request_message = MessageFactory.build(@connector, self) do |hnvsd|
        hnvsd.add_segment(Segments::HKENDv1.new)
      end
      request_message.compile

      Response.new(@connector.post(request_message))

      @connector.reset_message_number
    end

    private

    def initialization_successful?
      hirmg = response.find('HIRMG')
      return false if hirmg && hirmg.ret_val_1.code[0].to_i == 9

      hnvsd = response.find('HNVSD')
      hirmg = hnvsd.find('HIRMG')
      return false if hirmg && hirmg.ret_val_1.code[0].to_i == 9

      true
    end
  end
end
