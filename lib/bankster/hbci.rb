require 'httparty'
require "bankster/hbci/version"

require 'bankster/hbci/element_group'
require 'bankster/hbci/element_groups/segment_head'

require 'bankster/hbci/segment'
require 'bankster/hbci/segments/hnshk_v4'
require 'bankster/hbci/segments/hnsha_v2'
require 'bankster/hbci/segments/hnhbk_v3'
require 'bankster/hbci/segments/hnvsk_v3'
require 'bankster/hbci/segments/hnhbs_v1'
require 'bankster/hbci/segments/hnvsd_v1'

require 'bankster/hbci/segment_parser'


module Bankster
  module Hbci
    module Segments
      class Base
        attr_reader :messenger
        attr_reader :dialog
        attr_reader :credentials
        attr_accessor :message
        attr_writer :head

        def parse(string)
        end

        def initialize(dialog: nil, messenger: nil, credentials: nil, message: nil, **)
          @messenger   = messenger if messenger
          @dialog      = dialog if dialog
          @credentials = credentials if credentials
          @message     = message if message
        end

        def position_in_message
          message ? message.payload_index_of(self) + 3 : "X"
        end

        def head
          @head ||= "#{name}:#{position_in_message}:#{version}"
        end

        def name
          self.class.name.gsub(/^.*::/, '')
        end

        def to_s
          "#{self.class.name} "
        end

        def inspect
          to_s
        end
      end

      class HKIDN < Base
        def system_id
          "0"
        end

        def version
          2
        end

        def to_s
          "#{head}+280:#{credentials.bank_code}+#{credentials.user_id}+#{system_id}+1'"
        end
      end

      class HNVSD < Base
        def initialize(signed_payload:, **)
          @signed_payload = signed_payload
          super
        end

        def to_s
          content = @signed_payload.join('')
          "HNVSD:999:1+@#{content.size}@#{content}'"
        end
      end

      class HKSAL < Base; end
      class HKVSD < Base; end
      class HIASD < Base; end

      # Encoding Head
      class HNVSK < Base
        def version
          3
        end

        def position_in_message
          998
        end

        def to_s
          "#{head}+PIN:1+998+1+1::#{dialog.system_id}+1:#{Time.now.strftime("%Y%m%d")}:#{Time.now.strftime("%H%m%S")}+2:2:13:@8@00000000:5:1+280:#{dialog.credentials.bank_code}:#{dialog.credentials.user_id}:V:0:0+0'"
        end
      end

      # Signature Head
      class HNSHK < Base
        def version
          4
        end

        def position_in_message
          2
        end

        def to_s
          tan_mechanism = 999
          system_id = 0
          "#{head}+PIN:1+#{tan_mechanism}+#{message.sec_ref}+1+1+1::#{system_id}+1+1:#{Time.now.strftime("%Y%m%d")}:#{Time.now.strftime("%H%m%S")}+1:999:1+6:10:16+280:#{dialog.credentials.bank_code}:#{dialog.credentials.user_id}:S:0:0'"
        end
      end

      class HNHBK < Base
        def padded_length
          head_length = 29
          tail_length = 11
          length = head_length + tail_length + dialog.next_sent_message_number.size * 2 + dialog.id.size + message.encrypted_payload.to_s.size + message.enc_head.to_s.size
          length.to_s.rjust(12, "0")
        end

        def to_s
          "HNHBK:1:3+#{padded_length}+300+#{dialog.id}+#{dialog.next_sent_message_number}'"
        end

        def self.spec
          [
            [ :message_size, :dig, 12, :mandatory, 1 ],
            [ :hbci_version, :int, '<=3', :mandatory, 1 ]
          ]
        end
      end

      class HKVVB < Base
        def version
          3
        end
        def to_s
          "#{head}+3+12+0+rubyhbci+1.0'"  #hallo, ich beine eine solche software...
        end
      end

      class HNHBS < Base
        def version
          1
        end

        def position_in_message
          message.payload.size + 4
        end

        def to_s
          "#{head}+#{dialog.next_sent_message_number}'"
        end
      end
    end

    class Message
      attr_reader :dialog
      attr_reader :sec_ref

      def payload_index_of(segment)
        @payload.index(segment)
      end

      def enc_head
        Segments::HNVSKv3.build(dialog: dialog)
      end

      def sig_head
        Segments::HNSHKv4.build(dialog: dialog, message: self)
      end

      def sig_tail
        Segments::HNSHAv2.build(dialog: dialog, message: self)
      end

      def head
        Segments::HNHBKv3.build(dialog: dialog, message: self)
      end

      def tail
        Segments::HNHBSv1.build(dialog: dialog, message: self)
      end

      def raw
        enveloped.join('')
      end

      def enveloped
        [head, enc_head, encrypted_payload, tail]
      end

      def encrypted_payload
        Segments::HNVSDv1.build(message: self)
      end

      def signed_payload
        [sig_head, payload, sig_tail].flatten
      end

      def payload
        @payload.map do |segment|
          segment.message = self
          segment
        end
      end

      def initialize(dialog:)
        @sec_ref = rand(1..23) * 999999 + 1000000

        @dialog = dialog
        @payload = []
      end

      def add_payload(segment)
        @payload << segment
      end

      def inspect_payload
        string = "Message Payload #{payload.count} segments: \n"
        payload.each { |segment| string << "#{segment.to_s} \n" }
        string
      end
    end

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
        messenger.add_request_payload(Segments::HKIDN.new(credentials: credentials, dialog: self))
        messenger.add_request_payload(Segments::HKVVB.new(credentials: credentials, dialog: self))
        messenger.request!
      end
    end

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
