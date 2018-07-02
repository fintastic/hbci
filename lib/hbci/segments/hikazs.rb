# frozen_string_literal: true

module Hbci
  module Segments
    class HIKAZSv6 < Segment
      element_group :head, type: ElementGroups::SegmentHead
      element :max_entries
      element :min_signatures
      element :security_class
      element_group :account do
        element :retention_period
        element :allowed_input_entry_quantity
        element :allowed_request_all_accounts
        element :data_format
      end
    end

    class HIKAZSv7 < Segment
      element_group :head, type: ElementGroups::SegmentHead
      element :max_entries
      element :min_signatures
      element :security_class
      element_group :account do
        element :retention_period
        element :allowed_input_entry_quantity
        element :allowed_request_all_accounts
        element :data_format
      end
    end
  end
end
