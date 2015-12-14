module Bankster
  module Hbci
    module Segments

      # params for locking the pin
      class HIPSPSv1 < Segment
        element_group :head, type: ElementGroups::SegmentHead

        element :max_amount_of_transactions
        element :min_amount_of_signatures
        element :security_class
      end
    end
  end
end
