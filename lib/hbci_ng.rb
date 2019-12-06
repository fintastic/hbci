# frozen_string_literal: true

require 'active_support/concern'

require 'hbci_ng/config'
require 'hbci_ng/connector'
require 'hbci_ng/response'

require 'hbci_ng/parser'
require 'hbci_ng/message'
require 'hbci_ng/segment'
require 'hbci_ng/segment_element'

Dir["#{File.expand_path('..', __dir__)}/lib/hbci_ng/errors/*.rb"].each { |f| require f }
Dir["#{File.expand_path('..', __dir__)}/lib/hbci_ng/services/*.rb"].each { |f| require f }

module HbciNg
  def self.logger
    @logger ||= Logger.new(STDOUT, level: Logger::DEBUG)
  end

  def self.configure
    yield HbciNg::Config if block_given?
  end

  def self.config
    HbciNg::Config
  end
end
