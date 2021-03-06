# frozen_string_literal: true

module Hbci
  module Services
    class BaseReceiver
      attr_reader :connector
      attr_reader :dialog
      attr_reader :iban

      def initialize(connector, dialog, iban, version = nil)
        @connector = connector
        @dialog = dialog
        @iban = Ibanizator.iban_from_string(iban)
        @version = version

        # raise "The version #{@version} is not supported" if version && !supported_versions.include?(@version)
      end

      def perform
        raise NotImplementedError, "#{self.class.name}#perform is an abstract method."
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

      def version
        @version ||= supported_versions.max
      end

      def supported_versions
        raise NotImplementedError, "#{self.class.name}#supported_versions is an abstract method."
      end
    end
  end
end
