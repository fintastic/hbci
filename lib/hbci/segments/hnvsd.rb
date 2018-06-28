module Hbci
  module Segments
    class HNVSDv1 < Segment
      element_group :head, type: ElementGroups::SegmentHead
      element :content, type: :binary

      def after_build
        head.position = 999
        self.content = message.signed_payload.join('')
      end

      # def self.parse(string)
      #   segment_data = string.split('+',2)
      #   segment = self.new
      #   segment.content = segment_data[1]
      #   segment.head.type = 'HNVSD'
      #   segment
      # end
    end
  end
end
