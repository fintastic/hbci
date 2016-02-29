module Bankster
  module Hbci
    module Segments
      class HKIDNv2 < Segment
        element_group :head, type: ElementGroups::SegmentHead
        element_group :bank do
          element :country_code, default: 280
          element :code # blz
        end
        element :user_id  # "kunden_id"
        element :system_id, default: 0
        element :state, default: 1

        def after_build
          head.position = message ? message.payload_index_of(self) + 3 : 'X'
          bank.code = dialog.credentials.bank_code
          self.user_id = dialog.credentials.user_id
        end
      end
    end
  end
end
