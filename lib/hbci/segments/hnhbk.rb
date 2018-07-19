# frozen_string_literal: true

module Hbci
  module Segments
    class HNHBKv3 < Segment
      element_group :head, type: Hbci::ElementGroups::SegmentHead
      element :message_size
      element :hbci_version, default: 300
      element :dialog_id
      element :message_number
      element_group :referenced_message do
        element :dialog_id
        element :message_number
      end

      def compile
        self.message_size = '000000000000'
        self.dialog_id = request_message.dialog ? request_message.dialog.id : 0
        self.message_number = Connector.instance.message_number
      end

      def after_compile
        self.message_size = request_message.to_s.size.to_s.rjust(12, '0')
      end
    end
  end
end
