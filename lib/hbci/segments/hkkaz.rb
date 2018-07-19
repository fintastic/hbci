# frozen_string_literal: true

module Hbci
  module Segments
    class HKKAZv6 < Segment
      element_group :head, type: ElementGroups::SegmentHead
      element_group :account, type: ElementGroups::KTV2
      element :all_accounts, default: 'N'
      element :from
      element :to
      element :max_entries
      element :attach
    end

    class HKKAZv7 < Segment
      element_group :head, type: ElementGroups::SegmentHead
      element_group :account, type: ElementGroups::KTVInt
      element :all_accounts, default: 'N'
      element :from
      element :to
      element :max_entries
      element :attach
    end
  end
end
