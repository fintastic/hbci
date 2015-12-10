module Bankster
  module Hbci
    module Segments
      class HKVVBv3 < Segment

        element_group :head, type: ElementGroups::SegmentHead
        element :bpd_version, default: 3
        element :upd_version, default: 12
        element :dialog_language, default: 0
        element :product_name, default: "Bankster"
        element :product_version, default: Bankster::Hbci::VERSION

        def after_build
          self.head.position = message ? message.payload_index_of(self) + 3 : "X"
        end

      end
    end
  end
end
