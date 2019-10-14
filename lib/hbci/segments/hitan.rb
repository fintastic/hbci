# frozen_string_literal: true

module Hbci
  module Segments
    class HITANv6 < Segment
      element_group :head, type: ElementGroups::SegmentHead
      element :tan_process
      element :job_hash
      element :job_reference
      element :challenge
      element :challenge_hhd_uc
      element :challenge_expiry
      element :tan_mechanism
    end
  end
end
