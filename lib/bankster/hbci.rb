require 'httparty'
require 'money'
require "bankster/hbci/version"
require 'bankster/bank_credentials'

require 'bankster/hbci/message'
require 'bankster/hbci/request'
require 'bankster/hbci/response'
require 'bankster/hbci/messenger'
require 'bankster/hbci/element_group'
require 'bankster/hbci/segment_parser'
require 'bankster/hbci/dialog'
require 'bankster/hbci/client'

require 'bankster/hbci/element_groups/segment_head'
require 'bankster/hbci/element_groups/generated_element_groups'

require 'bankster/hbci/segment'

# require 'bankster/hbci/segments/segment_head'

require 'bankster/hbci/segments/param_segments'
require 'bankster/hbci/segments/param_segments_generated'
require 'bankster/hbci/segments/hnshk_v4'
require 'bankster/hbci/segments/hnsha_v2'
require 'bankster/hbci/segments/hnhbk_v3'
require 'bankster/hbci/segments/hnvsk_v3'
require 'bankster/hbci/segments/hnhbs_v1'
require 'bankster/hbci/segments/hnvsd_v1'
require 'bankster/hbci/segments/hkidn_v2'
require 'bankster/hbci/segments/hkvvb_v3'
require 'bankster/hbci/segments/hksal_v4'
require 'bankster/hbci/segments/segment_additions'

I18n.enforce_available_locales = false if I18n.available_locales.none?

module Bankster
  module Hbci

  end
end
