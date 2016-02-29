module Bankster
  module Hbci
    module Segments
      # Signature Closing Segment
      #
      # Counterpart of the Signature Opening (HNSHK)
      class HNSHAv2 < Bankster::Hbci::Segment

        # Segment Head
        element_group :head, type: ElementGroups::SegmentHead

        # Security Reference
        # MUST be the same as in signature opening (HNSHK)
        element :security_reference

        # Security validation result. Empty when using pin/tan.
        element :security_validation_result

        # User signature
        element_group :signature do
          element :pin
          element :tan
        end

        def after_build
          head.position      = message.payload.size + 3
          self.security_reference = message.sec_ref
          signature.pin      = dialog.credentials.pin
        end
      end
    end
  end
end
