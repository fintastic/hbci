module Bankster
  module Hbci
    module Segments
      class HKKAZv6 < Segment
        element_group :head, type: ElementGroups::SegmentHead
        element_group :account, type: ElementGroups::KTV2
        element :all_accounts, default: "N"
        element :from
        element :to
        element :max_entries
        element :attach


        def after_build
          self.head.position = "3"
        end
      end
    end
  end
end
