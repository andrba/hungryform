# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'hungryform/version'

Gem::Specification.new do |spec|
  spec.name          = "hungryform"
  spec.version       = HungryForm::VERSION
  spec.authors       = ["Andrey Bazhutkin"]
  spec.email         = ["andrey.bazhutkin@gmail.com"]
  spec.summary       = "A Ruby Library for working with multi page forms"
  spec.homepage      = "https://github.com/andrba/hungryform"
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.6"
  spec.add_development_dependency "rake"
  spec.add_development_dependency "rspec"
  spec.add_dependency 'activesupport'
  spec.add_dependency 'hashie'
end
