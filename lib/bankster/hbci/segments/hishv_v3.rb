module Bankster
  module Hbci
    module Segments

      # Security method
      class HISHVv3 < Segment
        element_group :head, type: ElementGroups::SegmentHead

        element :mix_applicable

        9.times do |i|
          element_group "supported_security_methods_#{i}".to_sym do
            element :code
            element :version
          end
        end
      end
    end
  end
end
