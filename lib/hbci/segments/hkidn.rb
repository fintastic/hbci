# frozen_string_literal: true

module Hbci
  module Segments
    class HKIDNv2 < Segment
      element_group :head, type: ElementGroups::SegmentHead
      element_group :bank do
        element :country_code, default: 280
        element :code # blz
      end
      element :user_id # "kunden_id"
      element :system_id
      element :state, default: 1

      def compile
        bank.code = request_message.connector.credentials.bank_code
        self.user_id = request_message.connector.credentials.user_id
        self.system_id = request_message.dialog ? request_message.dialog.system_id : 0
      end
    end
  end
end
