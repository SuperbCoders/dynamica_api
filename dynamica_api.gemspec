# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'dynamica_api/version'

Gem::Specification.new do |spec|
  spec.name          = 'dynamica_api'
  spec.version       = DynamicaAPI::VERSION
  spec.authors       = ['Alexander Borovykh']
  spec.email         = ['immaculate.pine@gmail.com']
  spec.summary       = %q{API for Dynamica forecasts service}
  spec.description   = %q{API for Dynamica forecasts service}
  spec.homepage      = ''
  spec.license       = 'MIT'

  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ['lib']

  spec.add_dependency 'hashie'
  spec.add_dependency 'rest_client'
  spec.add_dependency 'actionpack'

  spec.add_development_dependency 'bundler', '~> 1.7'
  spec.add_development_dependency 'rake', '~> 10.0'
end
