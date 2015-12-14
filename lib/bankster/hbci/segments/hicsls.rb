module Bankster
  module Hbci
    module Segments
      # Params for deleting a sepa direct debit
      class HICSLSv1 < Segment
        include SegmentHead
        include HIParams2
        element_group :delete_sepa_direct_debit_params do
          element :required_to_send_transaction_data
        end
      end
    end
  end
end
