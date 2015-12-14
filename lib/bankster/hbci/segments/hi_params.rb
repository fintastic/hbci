module Bankster
  module Hbci
    module Segments
      module HIParams1
        def self.included(klass)
          klass.element :max_amount_of_transactions
          klass.element :min_amount_of_signatures
        end
      end

      module HIParams2
        def self.included(klass)
          klass.element :max_amount_of_transactions
          klass.element :min_amount_of_signatures
          klass.element :security_class
        end
      end

      class HICSESv1 < Segment
        include SegmentHead
        include HIParams2
        element_group :scheduled_sepa_credit_transfer_params do
          element :minimum_offset_time
          element :maximum_offset_time
        end
      end

      class HISUBSv4 < Segment
        include SegmentHead
        include HIParams1
        element_group :multi_credit_transfer_params do
          element :max_amount_of_entries
          element :max_usage
          element :key
        end
      end

      class HITUBSv1 < Segment
        include SegmentHead
        include HIParams1
        element_group :list_scheduled_credit_transfer_params do
          element :can_give_timerange
        end
      end

      class HITUESv1 < Segment
        include SegmentHead
        include HIParams1
        element_group :params do
          element :min_pre_time
          element :max_pre_time
          element :max_usage
          element :key
        end
      end

      class HITUESv2 < Segment
        include SegmentHead
        include HIParams1
        element_group :params do
          element :min_pre_time
          element :max_pre_time
          element :max_usage
          element :key
        end
      end

      class HITULSv1 < Segment
        include SegmentHead
        include HIParams1
      end

      class HICCSSv1 < Segment
        include SegmentHead
        include HIParams2
      end

      class HISPASv1 < Segment
        include SegmentHead
        include HIParams2
        element_group :params do
          element :can_single_account_query
          element :can_national_account
          element :can_struct_usage
          99.times { |i| element "supported_format_#{i}" }
        end
      end

      class HICCMSv1 < Segment
        include SegmentHead
        include HIParams2
        element_group :params do
          element :max_number
          element :require_total
          element :can_single_transfer
        end
      end

      class HITUASv2 < Segment
        include SegmentHead
        include HIParams1
        element_group :edit_scheduled_credit_transfer_params do
          element :min_pre_time
          element :max_pre_time
          element :max_usage
          element :key
        end
      end
    end
  end
end
