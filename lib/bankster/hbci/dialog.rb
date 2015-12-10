module Bankster
  module Hbci
    class Dialog
      attr_reader :credentials
      attr_reader :hbci_version
      attr_reader :system_id
      attr_reader :sent_messages
      attr_reader :id

      def next_sent_message_number
        sent_messages.count + 1
      end

      def initialize(credentials = nil)
        @credentials = credentials
        @hbci_version = '3.0'
        @system_id = 0
        @sent_messages = []
        @id = 0
      end

      def initiate
        messenger = Messenger.new(dialog: self)
        messenger.add_request_payload(Segments::HKIDNv2.build(message: messenger.request, dialog: self))
        messenger.add_request_payload(Segments::HKVVBv3.build(message: messenger.request))
        messenger.request!
      end
    end
  end
end
