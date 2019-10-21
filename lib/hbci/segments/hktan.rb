# frozen_string_literal: true

module Hbci
  module Segments
    class HKTANv6 < Segment
      element_group :head, type: ElementGroups::SegmentHead
      element :tan_mechanism
      element :seg_id
      element :kti
      element :job_hash
      element :job_reference
      element :next_tan
    end
  end
end

