module Bankster
  module Hbci
    module Segments

      # Parameters of Communication
      class HIKOMv4 < Segment
        element_group :head, type: ElementGroups::SegmentHead
        element_group :bank_identification do
          element :country_code
          element :bank_code
        end
        element :default_language
        9.times do |i|
          element_group "communication_parameters_#{i}".to_sym do
            element :service
            element :address
            element :address_addition
            element :filter_function
            element :filter_function_code
          end
        end
      end
    end
  end
end
