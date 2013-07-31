# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'domain_name_validator/version'

Gem::Specification.new do |spec|
  spec.name          = 'domain_name_validator'
  spec.version       = DomainNameValidator::VERSION
  spec.authors       = ['Jeroen Jacobs']
  spec.email         = ['gems@jeroenj.be']
  spec.description   = 'Validates domain names in rails'
  spec.summary       = 'Validates domain names in rails'
  spec.homepage      = 'https://github.com/jeroenj/domain_name_validator'
  spec.license       = 'MIT'

  spec.files         = `git ls-files`.split($/)
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_dependency 'activemodel', '>= 3.0'
  spec.add_dependency 'public_suffix', '~> 1.3'
  spec.add_development_dependency 'bundler', '~> 1.3'
  spec.add_development_dependency 'rake'
end
