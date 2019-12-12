# frozen_string_literal: true

require 'httparty'
require 'cmxl'
require 'ibanizator'

require 'hbci/config'
require 'hbci/connector'
require 'hbci/response'
require 'hbci/parser'
require 'hbci/message'
require 'hbci/segment'
require 'hbci/segment_element'

require 'hbci/services/base'
require 'hbci/services/base_receiver'

Dir["#{File.expand_path('..', __dir__)}/lib/hbci/errors/*.rb"].each { |f| require f }
Dir["#{File.expand_path('..', __dir__)}/lib/hbci/services/*.rb"].each { |f| require f }

module Hbci
  def self.logger
    @logger ||= Logger.new(STDOUT, level: Logger::DEBUG)
  end

  def self.configure
    yield Hbci::Config if block_given?
  end

  def self.config
    Hbci::Config
  end
end
