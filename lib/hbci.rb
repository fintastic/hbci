# frozen_string_literal: true

# External gems
require 'httparty'
require 'money'
require 'monetize'
require 'cmxl'
require 'ibanizator'

require 'bank_credentials'

# Internal logic
require 'hbci/version'
require 'hbci/parser'
require 'hbci/segment_factory'
require 'hbci/dialog'
require 'hbci/message'
require 'hbci/request'
require 'hbci/response'
require 'hbci/element_unparser'
require 'hbci/connector'
require 'hbci/message_factory'

# Element groups
require 'hbci/element_group'
require 'hbci/element_groups/segment_head'
require 'hbci/element_groups/unknown'
require 'hbci/element_groups/generated_element_groups'

# Segments
require 'hbci/segment'
require 'hbci/segments/hnshk'
require 'hbci/segments/hnsha'
require 'hbci/segments/hnhbk'
require 'hbci/segments/hnvsk'
require 'hbci/segments/hnhbs'
require 'hbci/segments/hnvsd'
require 'hbci/segments/hkidn'
require 'hbci/segments/hkvvb'
require 'hbci/segments/hksal'
require 'hbci/segments/hkkaz'
require 'hbci/segments/hikaz'
require 'hbci/segments/hisal'
require 'hbci/segments/hirms'
require 'hbci/segments/hiupa'
require 'hbci/segments/hiupd'
require 'hbci/segments/hikaz'
require 'hbci/segments/hkend'
require 'hbci/segments/hikazs'
require 'hbci/segments/hisals'
require 'hbci/segments/hirmg'
require 'hbci/segments/hksyn'
require 'hbci/segments/hisyn'
require 'hbci/segments/unknown'

# Services
require 'hbci/services/base_receiver'
require 'hbci/services/transactions_receiver'
require 'hbci/services/balance_receiver'
require 'hbci/services/accounts_receiver'
require 'hbci/services/system_id_receiver'

I18n.enforce_available_locales = false if I18n.available_locales.none?

module Hbci
end
