module Bankster
  module Hbci
    class Messenger
      attr_reader :dialog
      attr_reader :request
      attr_reader :response

      def initialize(dialog:)
        @dialog = dialog
        @request = Message.new(dialog: dialog)
        @response = nil
      end

      def add_request_payload(segment)
        request.add_payload(segment)
      end

      def request!
        req = HTTParty.post(dialog.credentials.url, body: Base64.encode64(request.raw))
        response = Base64.decode64(req.response.body).split('\'')
        puts response
      end
    end
  end
end
