module Bankster
  module Hbci
    class Client
      attr_reader :credentials
      def initialize(credentials)
        @credentials  = credentials
        credentials.validate!
      end

      def transactions(start_date = nil, end_date = nil)
        @dialog = Dialog.new(credentials)
        @dialog.initiate

        # message = Message.new
        # message.add_payload(Segments::HKSAL.new(:my_accounts))
        # resp = @dialog.send(message)
      end
    end
  end
end
