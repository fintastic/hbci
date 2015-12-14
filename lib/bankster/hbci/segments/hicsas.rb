module Bankster
  module Hbci
    module Segments
      # Params for updating an already terminated sepa direct debit
      class HICSASv1 < Segment
        include SegmentHead
        include HIParams2
        element_group :update_terminated_sepa_direct_debit_params do
          element :minimum_time_ahead
          element :maximum_time_ahead
        end
      end
    end
  end
end
