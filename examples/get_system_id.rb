# frozen_string_literal: true

require_relative '../lib/hbci'
require_relative 'credentials'

Hbci::Connector.open(@credentials) do |connector|
  puts Hbci::Services::SystemIdReceiver.new(connector).perform
end
