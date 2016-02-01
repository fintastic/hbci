module Bankster
  module Hbci
    class Dialog
      attr_reader :credentials
      attr_reader :hbci_version
      attr_reader :system_id
      attr_reader :sent_messages
      attr_reader :tan_mechanism
      attr_reader :id
      attr_reader :accounts

      def next_sent_message_number
        sent_messages.count + 1
      end

      def initialize(credentials = nil)
        @credentials = credentials
        @hbci_version = '3.0'
        @system_id = 0
        @sent_messages = []
        @tan_mechanism = nil
        @id = 0
      end

      def initiate
        messenger = Messenger.new(dialog: self)

        identification_seg = Segments::HKIDNv2.build(message: messenger.request, dialog: self)
        preparation_seg = Segments::HKVVBv3.build(message: messenger.request)

        messenger.add_request_payload(identification_seg)
        messenger.add_request_payload(preparation_seg)

        messenger.request!

        if messenger.response && messenger.response.success?
          @tan_mechanism = messenger.response.payload.select{ |s| s.respond_to?(:head) && s.head.type == "HIRMS"  }.first.allowed_tan_mechanism
          @accounts = messenger.response.payload.select{ |s| s.respond_to?(:head) && s.head.type == "HIUPD"  }.map(&:ktv)
          @id = messenger.response.head.dialog_id
        end
      end
    end
  end
end
