module Bankster
  module Hbci
    module Segments
      # Signature Head Segment
      #
      # Top of the signature and counterpart of HNSHA
      # https://www.hbci-zka.de/dokumente/spezifikation_deutsch/fintsv3/FinTS_3.0_Security_Sicherheitsverfahren_HBCI_Rel_20130718_final_version.pdf#page=63
      class HNSHKv4 < Bankster::Hbci::Segment

        # segment head
        element_group :head, type: ElementGroups::SegmentHead

        # security profile
        # In case of pin, the method is 'PIN' and version is 1
        element_group :scurity_profile do
          element :method
          element :version
        end

        # Identifies the multi-step aproach for submitting tans.
        # 999 for initial 1 step approach.
        element :security_function_code

        # Random security control reference. MUST be the same
        # as in the signature footer
        element :security_control_reference

        # Unknown. Always "1"
        element :area_of_security_application

        # Unknown. Aways "1"
        element :role_of_security_supplier

        element_group :security_identification_details do
          element :type # default: 1
          element :cid # default: nil
          element :party_identification # system_id
        end

        element :security_reference_number # default 1

        element_group :secured_on do
          element :identifier # default 1
          element :date   # default  Time.now.strftime("%Y%m%d")
          element :time # default Time.now.strftime("%H%m%S")
        end

        element :hash_alg do
          element :usage # default 1
          element :code # default 999
          element :param_code # default 1
          element :param_value # default nil
        end

        element_group :sig_alg do
          element :usage # default 6
          element :code # default 10
          element :operation_mode # default 16
        end

        element_group :key do
          element :bank_country_code # 280
          element :bank_code # blz
          element :user_id # login id
          element :type # S
          element :number # 0
          element :version # 0
        end

        # default nil
        element_group :certificate do
          element :type
          element :content
        end
      end
    end
  end
end
