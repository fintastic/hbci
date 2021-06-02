# frozen_string_literal: true

lib = File.expand_path('lib', __dir__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'hbci/version'

Gem::Specification.new do |spec|
  spec.name          = 'hbci'
  spec.version       = Hbci::VERSION
  spec.authors       = ['Roman Lehnert', 'Alexander Klaiber']
  spec.email         = ['roman.lehnert@googlemail.com']

  spec.summary       = 'A Ruby hbci client'
  spec.description   = 'A pure ruby hbci banking client'
  spec.homepage      = 'https://github.com/fintastic/hbci'
  spec.license       = 'MIT'

  spec.files         = `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  spec.require_paths = ['lib']

  spec.add_runtime_dependency 'bank_credentials'
  spec.add_runtime_dependency 'cmxl', '~> 1.4'
  spec.add_runtime_dependency 'httparty', '~> 0.16'
  spec.add_runtime_dependency 'ibanizator', '~> 0.3'
  spec.add_runtime_dependency 'monetize', ['>=1.8', '<2.0.0']
  spec.add_runtime_dependency 'money', ['>=6.11', '<7.0.0']

  spec.add_development_dependency 'activesupport', '~> 6.0'
  spec.add_development_dependency 'byebug', '~> 11.0'
  spec.add_development_dependency 'rake', '~> 13.0'
  spec.add_development_dependency 'rspec', '~> 3.8'
  spec.add_development_dependency 'rubocop', '~> 1.16'
  spec.add_development_dependency 'timecop', '~> 0.9'
  spec.add_development_dependency 'webmock', '~> 3.4'
end
