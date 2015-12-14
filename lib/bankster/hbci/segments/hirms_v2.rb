module Bankster
  module Hbci
    module Segments

      # HIRMS gives a state about a specific segent
      class HIRMSv2 < Segment
        element_group :head, type: ElementGroups::SegmentHead
        99.times do |i|
          element_group "response_#{i}".to_sym do
            element :code
            element :related_element
            element :text
            element :param
          end
        end
      end
    end
  end
end
