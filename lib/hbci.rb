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

# Errors
require 'hbci/errors/hbci/base_error'
require 'hbci/errors/hbci/dialog_error'
require 'hbci/errors/hbci/service_unavailable'

# Element groups
require 'hbci/element_group'
require 'hbci/element_groups/segment_head'
require 'hbci/element_groups/unknown'
require 'hbci/element_groups/generated_element_groups'

# Segments
require 'hbci/segment'
Dir["#{File.expand_path('..', __dir__)}/lib/hbci/segments/*.rb"].each { |f| require f }

# Services
require 'hbci/services/base_receiver'
require 'hbci/services/transactions_receiver'
require 'hbci/services/balance_receiver'
require 'hbci/services/accounts_receiver'

I18n.enforce_available_locales = false if I18n.available_locales.none?

Money.locale_backend = nil

module Hbci
  def self.logger
    @logger ||= Logger.new(STDOUT, level: Logger::DEBUG)
  end
end
