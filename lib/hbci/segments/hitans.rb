# frozen_string_literal: true

module Hbci
  module Segments
    class HITANSv6 < Segment
      element_group :head, type: ElementGroups::SegmentHead
      element :max_jobs
      element :amount_sig
      element :security_class
      element_group :second_factor_params do
        element :one_factor_allowed
        element :multi_tan_allowed
        element :job_reference
        element :security_function
        element :tan_mechanism
        element :zka_tan_mechanism
        element :zka_version_tan_mechanism
        element :name
        element :max_tan_length
      end
    end
  end
end
