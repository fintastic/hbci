# frozen_string_literal: true

module Hbci
  module Segments
    class HNVSKv3 < Hbci::Segment
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
        element :date, default: ->(_eg) { Time.now.strftime('%Y%m%d') }
        element :time, default: ->(_eg) { Time.now.strftime('%H%m%S') }
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

      def compile
        head.position = 998
        security_identification_details.party_identification = request_message.dialog ? request_message.dialog.system_id : 0
        key.bank_code = Connector.instance.credentials.bank_code
        key.user_id = Connector.instance.credentials.user_id
      end
    end
  end
end
