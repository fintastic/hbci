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

      class HIDSBSv1 < Segment
        element_group :head, type: ElementGroups::SegmentHead
        element :max_amount_of_transactions
        element :min_amount_of_signatures
        element :security_class
        element_group :params do
          element :misc_1
          element :misc_2
          element :misc_3
        end
      end

      class HICUBSv1 < Segment
        element_group :head, type: ElementGroups::SegmentHead
        element :max_amount_of_transactions
        element :min_amount_of_signatures
        element :security_class
        element_group :params do
          element :misc_1
        end
      end

      class HIDSWSv1 < Segment
        element_group :head, type: ElementGroups::SegmentHead
        element :max_amount_of_transactions
        element :min_amount_of_signatures
        element :security_class
        element_group :params do
          element :misc_1
        end
      end

      class HIECASv1 < Segment
        element_group :head, type: ElementGroups::SegmentHead
        element :max_amount_of_transactions
        element :min_amount_of_signatures
        element :security_class
        element_group :params do
          99.times do |i|
            element "param_#{i}".to_sym
          end
        end
      end

      class HIDBSSv6 < Segment
        element_group :head, type: ElementGroups::SegmentHead
        element :max_amount_of_transactions
        element :min_amount_of_signatures
        element :security_class
        element_group :params do
          99.times do |i|
            element "param_#{i}".to_sym
          end
        end
      end

      class HIAUBSv6 < Segment
        element_group :head, type: ElementGroups::SegmentHead
        element :max_amount_of_transactions
        element :min_amount_of_signatures
        element :security_class
        element_group :params do
          99.times do |i|
            element "param_#{i}".to_sym
          end
        end
      end

      class HIVISSv1 < Segment
        element_group :head, type: ElementGroups::SegmentHead
        element :max_amount_of_transactions
        element :min_amount_of_signatures
        element :security_class
        element_group :params do
          99.times do |i|
            element "param_#{i}".to_sym
          end
        end
      end

      class HIAZSSv1 < Segment
        element_group :head, type: ElementGroups::SegmentHead
        element :max_amount_of_transactions
        element :min_amount_of_signatures
        element :security_class
        element_group :params do
          99.times do |i|
            element "param_#{i}".to_sym
          end
        end
      end

      class HIDBSSv1 < Segment
        element_group :head, type: ElementGroups::SegmentHead
        element :max_amount_of_transactions
        element :min_amount_of_signatures
        element :security_class
        element_group :params do
          99.times do |i|
            element "param_#{i}".to_sym
          end
        end
      end

      class HIBMBSv1 < Segment
        element_group :head, type: ElementGroups::SegmentHead
        element :max_amount_of_transactions
        element :min_amount_of_signatures
        element :security_class
        element_group :params do
          99.times do |i|
            element "param_#{i}".to_sym
          end
        end
      end

      class HIDMBSv1 < Segment
        element_group :head, type: ElementGroups::SegmentHead
        element :max_amount_of_transactions
        element :min_amount_of_signatures
        element :security_class
        element_group :params do
          99.times do |i|
            element "param_#{i}".to_sym
          end
        end
      end

      class HIBBSSv1 < Segment
        element_group :head, type: ElementGroups::SegmentHead
        element :max_amount_of_transactions
        element :min_amount_of_signatures
        element :security_class
        element_group :params do
          99.times do |i|
            element "param_#{i}".to_sym
          end
        end
      end

      class GIVPDSv1 < Segment
        element_group :head, type: ElementGroups::SegmentHead
        element :max_amount_of_transactions
        element :min_amount_of_signatures
        element :security_class
        element_group :params do
          99.times do |i|
            element "param_#{i}".to_sym
          end
        end
      end

      class GIVPUSv1 < Segment
        element_group :head, type: ElementGroups::SegmentHead
        element :max_amount_of_transactions
        element :min_amount_of_signatures
        element :security_class
        element_group :params do
          99.times do |i|
            element "param_#{i}".to_sym
          end
        end
      end

      class HIPPDSv2 < Segment
        element_group :head, type: ElementGroups::SegmentHead

        element :max_amount_of_transactions
        element :min_amount_of_signatures
        element :security_class

        element_group :prepaid_load_params do
          element :option_1_number
          element :option_1_provider
          element :option_1_product
          element :option_1_custom_load_amount_alowed
          element :option_1_min_load_amount
          element :option_1_max_load_amount
          element :option_1_possible_load_amounts

          element :option_2_number
          element :option_2_provider
          element :option_2_product
          element :option_2_custom_load_amount_alowed
          element :option_2_min_load_amount
          element :option_2_max_load_amount
          element :option_2_possible_load_amounts

          element :option_3_number
          element :option_3_provider
          element :option_3_product
          element :option_3_custom_load_amount_alowed
          element :option_3_min_load_amount
          element :option_3_max_load_amount
          element :option_3_possible_load_amounts

          element :option_4_number
          element :option_4_provider
          element :option_4_product
          element :option_4_custom_load_amount_alowed
          element :option_4_min_load_amount
          element :option_4_max_load_amount
          element :option_4_possible_load_amounts

          element :option_5_number
          element :option_5_provider
          element :option_5_product
          element :option_5_custom_load_amount_alowed
          element :option_5_min_load_amount
          element :option_5_max_load_amount
          element :option_5_possible_load_amounts

          element :option_6_number
          element :option_6_provider
          element :option_6_product
          element :option_6_custom_load_amount_alowed
          element :option_6_min_load_amount
          element :option_6_max_load_amount
          element :option_6_possible_load_amounts
        end
      end

      # params for updating the pin
      class HIQTGSv1 < Segment
        element_group :head, type: ElementGroups::SegmentHead

        element :max_amount_of_transactions
        element :min_amount_of_signatures
        element :security_class
      end

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
