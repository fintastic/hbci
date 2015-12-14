module Bankster
  module Hbci
    class Messenger
      attr_reader :dialog
      attr_reader :request
      attr_reader :response

      def initialize(dialog:)
        @dialog = dialog
        @request = Request.new(dialog: dialog)
        @response = nil
      end

      def add_request_payload(segment)
        request.add_payload(segment)
      end

      def request!
        req = HTTParty.post(dialog.credentials.url, body: Base64.encode64(request.raw))
        raw_response = Base64.decode64(req.response.body)
        @response = Response.parse(dialog: dialog, raw_response: raw_response)
      end
    end
  end
end
