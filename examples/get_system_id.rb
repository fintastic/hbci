# frozen_string_literal: true

require_relative '../lib/hbci'
require_relative 'credentials'

puts Hbci::Services::SystemIdReceiver.new.perform
