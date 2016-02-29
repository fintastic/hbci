# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'bankster/hbci/version'

Gem::Specification.new do |spec|
  spec.name          = 'bankster-hbci'
  spec.version       = Bankster::Hbci::VERSION
  spec.authors       = ['Roman Lehnert']
  spec.email         = ['roman.lehnert@googlemail.com']

  spec.summary       = %q{summ}
  spec.description   = %q{my desc}
  spec.homepage      = 'http://google.de'
  spec.license       = 'MIT'

  # Prevent pushing this gem to RubyGems.org by setting 'allowed_push_host', or
  # delete this section to allow pushing this gem to any host.
  if spec.respond_to?(:metadata)
    spec.metadata['allowed_push_host'] = 'TODO: Set to "http://mygemserver.com"'
  else
    raise 'RubyGems 2.0 or newer is required to protect against public gem pushes.'
  end

  spec.files         = `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  spec.bindir        = 'exe'
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ['lib']

  spec.add_runtime_dependency 'httparty'
  spec.add_runtime_dependency 'bankster-bank_credentials'
  spec.add_runtime_dependency 'money'
  spec.add_runtime_dependency 'monetize'
  spec.add_runtime_dependency 'cmxl', '~> 0.1.3'

  spec.add_development_dependency 'bundler', '~> 1.10'
  spec.add_development_dependency 'rake', '~> 10.0'
  spec.add_development_dependency 'rspec'
  spec.add_development_dependency 'timecop'
  spec.add_development_dependency 'byebug'
  spec.add_development_dependency 'nokogiri'
  spec.add_development_dependency 'activesupport'
  spec.add_development_dependency 'webmock'
  spec.add_development_dependency 'ruby-prof'
end
