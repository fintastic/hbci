# frozen_string_literal: true

module Hbci
  module Services
    class SystemIdReceiver
      attr_reader :connector

      def initialize(connector)
        @connector = connector
      end

      def perform
        request_message = MessageFactory.build(connector, nil) do |hnvsd|
          hnvsd.add_segment(Segments::HKIDNv2.new)
          hnvsd.add_segment(Segments::HKVVBv3.new)
          hnvsd.add_segment(Segments::HKSYNv3.new)
        end
        request_message.compile

        @response = Response.new(connector.post(request_message))

        raise @response.to_s unless request_successful?

        @response.find('HNVSD').find('HISYN').system_id
      end

      private

      def request_successful?
        hirmg = @response.find('HIRMG')
        return false if hirmg && hirmg.ret_val_1.code[0].to_i == 9

        hnvsd = @response.find('HNVSD')
        hirmg = hnvsd.find('HIRMG')
        return false if hirmg && hirmg.ret_val_1.code[0].to_i == 9

        true
      end
    end
  end
end
