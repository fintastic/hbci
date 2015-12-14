module Bankster
  module Hbci
    module Segments

      # HIRMS gives a state about a specific segent
      class HIBPAv3 < Segment
        element_group :head, type: ElementGroups::SegmentHead
        element :bpd_version
        element_group :bank_identification do
          element :country_code
          element :bank_code
        end
        element :bank_name
        element :amount_of_supported_business_transactions
        element_group :supported_languages do
          9.times { |i| element "language_#{i}".to_sym }
        end
        element_group :supported_hbci_versions do
          9.times { |i| element "version_#{i}".to_sym }
        end
        element :maximum_message_size
        element :min_timeout
        element :max_timeout
      end
    end
  end
end
