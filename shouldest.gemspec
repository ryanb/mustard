# -*- encoding: utf-8 -*-
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'shouldest/version'

Gem::Specification.new do |gem|
  gem.name          = "shouldest"
  gem.version       = Shouldest::VERSION
  gem.authors       = ["Ryan Bates"]
  gem.email         = ["ryan@railscasts.com"]
  gem.description   = "Simple \"should\" matchers for specs."
  gem.summary       = "Adds \"should\" and \"should_not\" methods which can have matchers called upon them. Matchers can be added easily."
  gem.homepage      = "https://github.com/ryanb/shouldest"

  gem.files         = `git ls-files`.split($/)
  gem.test_files    = gem.files.grep(%r{^spec/})
  gem.require_paths = ["lib"]

  gem.add_development_dependency 'rspec', '~> 2.12.0'
end
