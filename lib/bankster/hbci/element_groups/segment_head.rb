module Bankster
  module Hbci
    module ElementGroups
      class SegmentHead < ElementGroup
        element :type
        element :position
        element :version
        element :reference
      end
    end
  end
end
