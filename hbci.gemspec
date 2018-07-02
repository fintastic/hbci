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

  spec.add_runtime_dependency 'bank_credentials'
  spec.add_runtime_dependency 'cmxl', '~> 1.1.0'
  spec.add_runtime_dependency 'httparty'
  spec.add_runtime_dependency 'ibanizator'
  spec.add_runtime_dependency 'monetize'
  spec.add_runtime_dependency 'money'

  spec.add_development_dependency 'activesupport'
  spec.add_development_dependency 'bundler', '~> 1.10'
  spec.add_development_dependency 'byebug'
  spec.add_development_dependency 'rake', '~> 12.3'
  spec.add_development_dependency 'rspec'
  spec.add_development_dependency 'rubocop'
  spec.add_development_dependency 'timecop'
  spec.add_development_dependency 'webmock'
end
