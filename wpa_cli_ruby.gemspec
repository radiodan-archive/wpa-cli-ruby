# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'wpa_cli_ruby/version'

Gem::Specification.new do |spec|
  spec.name          = "wpa_cli_ruby"
  spec.version       = WpaCliRuby::VERSION
  spec.authors       = ["Chris Lowis"]
  spec.email         = ["chris.lowis@gmail.com"]
  spec.description   = %q{A ruby wrapper for the wpa_cli command line utility}
  spec.summary       = %q{A ruby wrapper for the wpa_cli command line utility}
  spec.homepage      = ""
  spec.license       = "Apache"

  spec.files         = `git ls-files`.split($/)
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.3"
  spec.add_development_dependency "rake"
  spec.add_development_dependency "mocha"
end
