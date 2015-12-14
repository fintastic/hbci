module Bankster
  module Hbci
    module Segments

      # Params for BankTransactions
      class HIEKASv5 < Segment
        element_group :head, type: ElementGroups::SegmentHead
        element :max_amount_of_transactions
        element :min_amount_of_signatures
        element :security_class
        element_group :transaction_statement_params do
          element :number_allowed
          element :acknowledgement_required
          element :amount_of_transactions_allowed
          9.times { |i| element "format_#{i}".to_sym }
        end
      end
    end
  end
end
