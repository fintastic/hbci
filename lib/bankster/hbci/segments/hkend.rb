module Bankster
  module Hbci
    module Segments
      class HKENDv1 < Segment
        element_group :head, type: ElementGroups::SegmentHead
        element :dialog_id

        def after_build
          self.dialog_id = dialog.id
          self.head.position = '3'
        end
      end
    end
  end
end
