# frozen_string_literal: true

module Hbci
  class DialogError < BaseError
    attr_reader :hbci_response

    def initialize(msg, hbci_response = nil)
      super(msg)
      @hbci_response = hbci_response
    end
  end
end
