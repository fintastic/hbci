module Hbci
  module Segments
    class HIRMGv2 < Segment
      element_group :head, type: ElementGroups::SegmentHead
      1.upto(99) do |i|
        element_group "ret_val_#{i}".to_sym, type: ElementGroups::RetVal
      end
    end
  end
end
