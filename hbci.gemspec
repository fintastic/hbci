# frozen_string_literal: true

lib = File.expand_path('lib', __dir__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'hbci/version'

Gem::Specification.new do |spec|
  spec.name          = 'hbci'
  spec.version       = Hbci::VERSION
  spec.authors       = ['Roman Lehnert']
  spec.email         = ['roman.lehnert@googlemail.com']

  spec.summary       = 'A Ruby hbci client'
  spec.description   = 'A pure ruby hbci banking client'
  spec.homepage      = 'http://'
  spec.license       = 'MIT'

  spec.files         = `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  spec.require_paths = ['lib']

  spec.add_runtime_dependency 'bank_credentials', '~> 0.1'
  spec.add_runtime_dependency 'cmxl', '~> 1.1'
  spec.add_runtime_dependency 'httparty', '~> 0.16'
  spec.add_runtime_dependency 'ibanizator', '~> 0.3'
  spec.add_runtime_dependency 'monetize', '~> 1.8'
  spec.add_runtime_dependency 'money', '6.12.0'

  spec.add_development_dependency 'activesupport', '~> 5.2'
  spec.add_development_dependency 'bundler', '~> 1.10'
  spec.add_development_dependency 'byebug', '~> 10.0'
  spec.add_development_dependency 'rake', '~> 12.3'
  spec.add_development_dependency 'rspec',  '~> 3.7'
  spec.add_development_dependency 'rubocop', '~> 0.57'
  spec.add_development_dependency 'timecop', '~> 0.9'
  spec.add_development_dependency 'webmock', '~> 3.4'
end
