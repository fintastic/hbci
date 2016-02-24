module Bankster
  module Hbci
    module Segments
      class Unknown < Segment
        element_group :head, type: ElementGroups::SegmentHead
        99.times do |i|
          element_group "element_group_#{i}".to_sym, type: ElementGroups::Unknown
        end

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
