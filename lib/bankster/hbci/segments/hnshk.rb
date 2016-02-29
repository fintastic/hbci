module Bankster
  module Hbci
    module Segments
      # Signature Head Segment
      #
      # Top of the signature and counterpart of HNSHA
      # https://www.hbci-zka.de/dokumente/spezifikation_deutsch/fintsv3/FinTS_3.0_Security_Sicherheitsverfahren_HBCI_Rel_20130718_final_version.pdf#page=63
      class HNSHKv4 < Bankster::Hbci::Segment
        element_group :head, type: ElementGroups::SegmentHead do
          element :position, default: 2
        end

        element_group :security_profile do
          element :security_method, default: 'PIN'
          element :version, default: 1
        end

        element :tan_mechanism, default: 999

        # Random security control reference. MUST be the same
        # as in the signature footer
        element :security_reference

        element :area_of_security_application, default: 1
        element :role_of_security_supplier, default: 1
        element_group :security_identification_details do
          element :type, default: 1
          element :cid
          element :party_identification # system_id
        end

        element :security_reference_number, default: 1

        element_group :secured_at do
          element :identifier, default: 1
          element :date, default: ->(_eg) { Time.now.strftime('%Y%m%d') }
          element :time, default: ->(_eg) { Time.now.strftime('%H%m%S') }
        end

        element_group :hash_alg do
          element :usage, default: 1
          element :code, default: 999
          element :param_code, default: 1
          element :param_value
        end

        element_group :sig_alg do
          element :usage, default: 6
          element :code, default: 10
          element :operation_mode, default: 16
        end

        element_group :key do
          element :bank_country_code, default: 280
          element :bank_code # blz
          element :user_id # login id  # "Benutzerkennung"
          element :type, default: 'S'
          element :number, default: 0
          element :version, default: 0
        end

        def after_build
          self.security_reference = message.sec_ref
          security_identification_details.party_identification = dialog.system_id
          key.bank_code = dialog.credentials.bank_code
          key.user_id = dialog.credentials.user_id

          self.tan_mechanism = dialog.tan_mechanism if dialog.tan_mechanism
        end
      end
    end
  end
end
