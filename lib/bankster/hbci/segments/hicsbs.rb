module Bankster
  module Hbci
    module Segments
      # Params for updating an already terminated sepa direct debit
      class HICSBSv1 < Segment
        include SegmentHead
        include HIParams2
        element_group :existing_terminated_sepa_direct_debit_params do
          element :entry_of_amount_allowed
          element :possible_time_range
        end
      end
    end
  end
end
