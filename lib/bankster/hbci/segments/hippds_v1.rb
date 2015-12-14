module Bankster
  module Hbci
    module Segments

      # Params for loading a prepaid mobile phone card
      # See https://www.hbci-zka.de/dokumente/aenderungen/V3.0/GV_Prepaidkarte_laden.pdf
      class HIPPDSv1 < Segment
        element_group :head, type: ElementGroups::SegmentHead

        element :max_amount_of_transactions
        element :min_amount_of_signatures
        element :security_class

        element_group :prepaid_load_params do
          element :provider
          element :proider_name
          element :product_name
          element :custom_load_amount_allowed
          element :minimum_load_amount
          element :maximum_load_amount
          element :possible_load_amounts
        end
      end
    end
  end
end

