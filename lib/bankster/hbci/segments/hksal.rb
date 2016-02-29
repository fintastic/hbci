module Bankster
  module Hbci
    module Segments
      class HKSALv4 < Segment
        element_group :head, type: ElementGroups::SegmentHead
        element_group :account do
          element :number
          element :country, default: 280
          element :code # blz
        end
        element :all_accounts, default: 'N'

        def after_build
          head.position = '3'
        end
      end
    end
  end
end
