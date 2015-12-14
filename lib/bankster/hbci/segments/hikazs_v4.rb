module Bankster
  module Hbci
    module Segments

      # Params for BankTransactions
      class HIKAZSv4 < Segment
        element_group :head, type: ElementGroups::SegmentHead

        element :max_amount_of_transactions
        element :min_amount_of_signatures

        element_group :time_params do
          element :store_days
          element :max_entries_allowed
        end
      end
    end
  end
end
