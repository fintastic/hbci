$LOAD_PATH.unshift File.expand_path('../lib', __dir__)

require 'byebug'
require 'bankster/hbci'
require 'timecop'
require 'webmock/rspec'
require 'support/message_stubs'
require 'support/mocks'
require 'support/request_stubs'

RSpec.configure do |config|
  config.after(:each) do
    Timecop.return
  end
end
