# frozen_string_literal: true

$LOAD_PATH.unshift File.expand_path('../lib', __dir__)

require 'byebug'
require 'hbci'
require 'timecop'
require 'webmock/rspec'

Dir["#{File.dirname(__FILE__)}/support/**/*.rb"].each { |f| require f }

RSpec.configure do |config|
  config.include_context('segment', type: :segment)
  config.include_context('receiver', type: :receiver)
  config.after(:each) do
    Timecop.return
  end
end
