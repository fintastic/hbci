$LOAD_PATH.unshift File.expand_path('../../lib', __FILE__)
require 'byebug'
require 'bankster/hbci'
require 'timecop'
require 'webmock/rspec'
require 'support/message_stubs'

# @çount = 0
# WebMock.disable_net_connect!(:allow => [
#   lambda { |uri|
#     byebug
#     @count = @count + 1
#     @count <= 1
#   },
#   /ample.org/,
#   'bbc.co.uk'
# ])
