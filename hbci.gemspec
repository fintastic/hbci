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

  spec.add_runtime_dependency 'cmxl', '~> 1.4'
  spec.add_runtime_dependency 'httparty', '~> 0.16'
  spec.add_runtime_dependency 'ibanizator', '~> 0.3'

  spec.add_development_dependency 'rake'
  spec.add_development_dependency 'rspec'
  spec.add_development_dependency 'rubocop'
  spec.add_development_dependency 'timecop'
  spec.add_development_dependency 'webmock'
end
