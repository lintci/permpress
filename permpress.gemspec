# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'permpress/version'

Gem::Specification.new do |spec|
  spec.name          = 'permpress'
  spec.version       = Permpress::VERSION
  spec.authors       = ['Allen Madsen']
  spec.email         = ['blatyo@gmail.com']
  spec.summary       = 'Standardizes execution of various linters.'
  spec.description   = 'Standardizes execution of various linters.'
  spec.homepage      = 'https://github.com/lintci/permpress'
  spec.license       = 'MIT'

  spec.files         = `git ls-files -z`.split("\u0000")
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ['lib']

  spec.add_runtime_dependency 'thor'
  spec.add_runtime_dependency 'bundler'

  spec.add_development_dependency 'rake', '~> 10.0'
  spec.add_development_dependency 'rspec'
  spec.add_development_dependency 'pry-byebug'
end
