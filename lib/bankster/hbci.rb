# External gems
require 'httparty'
require 'money'
require 'cmxl'

# External gems from the bankster ecosystem
require 'bankster/bank_credentials'

# Internal logic
require 'bankster/hbci/version'
require 'bankster/hbci/parser'
require 'bankster/hbci/segment_factory'
require 'bankster/hbci/client'
require 'bankster/hbci/dialog'
require 'bankster/hbci/messenger'
require 'bankster/hbci/message'
require 'bankster/hbci/request'
require 'bankster/hbci/response'


# Element groups
require 'bankster/hbci/element_group'
require 'bankster/hbci/element_groups/segment_head'
require 'bankster/hbci/element_groups/unknown'
require 'bankster/hbci/element_groups/generated_element_groups'

# Segments
require 'bankster/hbci/segment'
require 'bankster/hbci/segments/hnshk'
require 'bankster/hbci/segments/hnsha'
require 'bankster/hbci/segments/hnhbk'
require 'bankster/hbci/segments/hnvsk'
require 'bankster/hbci/segments/hnhbs'
require 'bankster/hbci/segments/hnvsd'
require 'bankster/hbci/segments/hkidn'
require 'bankster/hbci/segments/hkvvb'
require 'bankster/hbci/segments/hksal'
require 'bankster/hbci/segments/hkkaz'
require 'bankster/hbci/segments/hikaz'
require 'bankster/hbci/segments/hisal'
require 'bankster/hbci/segments/hirms'
require 'bankster/hbci/segments/hiupd'
require 'bankster/hbci/segments/hikaz'
require 'bankster/hbci/segments/unknown'

I18n.enforce_available_locales = false if I18n.available_locales.none?

module Bankster
  module Hbci

  end
end
