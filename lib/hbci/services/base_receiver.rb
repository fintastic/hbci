# frozen_string_literal: true

module Hbci
  module Services
    class BaseReceiver
      attr_reader :dialog
      attr_reader :iban

      def initialize(dialog, iban, version = nil)
        @dialog = dialog
        @iban = Ibanizator.iban_from_string(iban)
        @version = version

        raise "The version #{@version} is not supported" if version && !supported_versions.include?(@version)
      end

      def perform
        raise NotImplementedError, "#{self.class.name}#perform is an abstract method."
      end

      private

      def version
        @version ||= supported_versions.max
      end

      def supported_versions
        raise NotImplementedError, "#{self.class.name}#supported_versions is an abstract method."
      end
    end
  end
end
