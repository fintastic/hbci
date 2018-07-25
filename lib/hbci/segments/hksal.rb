# frozen_string_literal: true

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
    end

    class HKSALv6 < Segment
      element_group :head, type: ElementGroups::SegmentHead
      element_group :account, type: ElementGroups::KTV2
      element :all_accounts, default: 'N'
      element :max_entries
      element :attach
    end

    class HKSALv7 < Segment
      element_group :head, type: ElementGroups::SegmentHead
      element_group :account, type: ElementGroups::KTVInt
      element :all_accounts, default: 'N'
      element :max_entries
      element :attach
    end
  end
end
