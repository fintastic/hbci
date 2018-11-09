# frozen_string_literal: true

module Hbci
  module Segments
    class HISYNv4 < Segment
      element_group :head, type: ElementGroups::SegmentHead
      element :system_id
      element :msg_number
      element :sec_ref_key
      element :sec_ref_sig
    end
  end
end
