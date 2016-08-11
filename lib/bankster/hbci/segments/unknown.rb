module Bankster
  module Hbci
    module Segments
      class Unknown < Segment
        element_group :head, type: ElementGroups::SegmentHead

        def self.type
          'Unknown'
        end

        def self.version
          '0'
        end
      end
    end
  end
end
