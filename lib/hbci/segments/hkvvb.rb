module Hbci
  module Segments
    class HKVVBv3 < Segment
      element_group :head, type: ElementGroups::SegmentHead
      element :bpd_version, default: 0
      element :upd_version, default: 0
      element :dialog_language, default: 0
      element :product_name, default: 'Bankster'
      element :product_version, default: Hbci::VERSION

      def after_build
        head.position = 4
        self.dialog_language = 1
      end
    end
  end
end
