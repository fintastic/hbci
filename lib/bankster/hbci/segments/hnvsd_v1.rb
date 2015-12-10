module Bankster
  module Hbci
    module Segments
      class HNVSDv1 < Segment
        element_group :head, type: ElementGroups::SegmentHead
        element :content

        def after_build
          self.head.position = 999
          data = self.message.signed_payload.join('')
          self.content = "@#{data.size}@#{data}"
        end
      end
    end
  end
end
