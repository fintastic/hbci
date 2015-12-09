module Bankster
  module Hbci
    module ElementGroups
      class SegmentHead < ElementGroup
        element :type
        element :position
        element :version
      end
    end
  end
end
