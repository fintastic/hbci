# frozen_string_literal: true

$LOAD_PATH.unshift File.expand_path('../lib', __dir__)

require 'byebug'
require 'hbci'
require 'timecop'
require 'webmock/rspec'

Dir["#{File.dirname(__FILE__)}/support/**/*.rb"].each { |f| require f }

RSpec.configure do |config|
  config.include_context('segment', type: :segment)

  config.around do |example|
    Timecop.freeze(Time.mktime(2019, 9, 25, 9, 30) ) { example.run }
  end
end
