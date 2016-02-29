module Bankster
  module Hbci
    module Segments
      class HNVSKv3 < Bankster::Hbci::Segment

        element_group :head, type: ElementGroups::SegmentHead do
          element :position, default: 998
        end

        element_group :security_profile do
          element :method, default: 'PIN'
          element :version, default: 1
        end

        element :security_function_code, default: 998

        element :role_of_security_supplier, default: 1

        element_group :security_identification_details do
          element :type, default: 1
          element :cid
          element :party_identification # system_id
        end

        element_group :secured_at do
          element :identifier, default: 1
          element :date, default: ->(eg) { Time.now.strftime('%Y%m%d') }
          element :time , default: ->(eg) { Time.now.strftime('%H%m%S') }
        end

        element_group :enc_alg do
          element :usage, default: 2
          element :operation_mode, default: 2
          element :code, default: 13
          element :key, default: '@5@NOKEY'
          element :type, default: 6
          element :additional_name, default: 1
          element :additional_value
        end

        element_group :key do
          element :bank_country_code, default: 280
          element :bank_code # blz
          element :user_id # login id
          element :type, default: 'V'
          element :number, default: 1
          element :version, default: 1
        end

        element :compression_method, default: 0

        def after_build
          security_identification_details.party_identification = dialog.system_id
          key.bank_code = dialog.credentials.bank_code
          key.user_id = dialog.credentials.user_id
        end
      end
    end
  end
end
