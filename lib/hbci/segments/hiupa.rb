# frozen_string_literal: true

module Hbci
  module Segments
    class HIUPAv4 < Segment
      element_group :head, type: ElementGroups::SegmentHead
      element :user_id
      element :upd_version
      element :upd_usage
    end
  end
end
