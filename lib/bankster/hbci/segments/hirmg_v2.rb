module Bankster
  module Hbci
    module Segments

      # HIRMG gives a state about the overall message. 
      class HIRMGv2 < Segment
        element_group :head, type: ElementGroups::SegmentHead
        element_group :response do
          element :code
          element :related_element
          element :text
          element :param
        end
      end
    end
  end
end
