# frozen_string_literal: true

module HbciNg
  class Response
    def initialize(raw_response)
      @raw_response = raw_response.force_encoding('iso-8859-1')
    end

    def to_s
      @raw_response
    end
  end
end
