# -*- encoding: utf-8 -*-
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'musts/version'

Gem::Specification.new do |gem|
  gem.name          = "musts"
  gem.version       = Musts::VERSION
  gem.authors       = ["Ryan Bates"]
  gem.email         = ["ryan@railscasts.com"]
  gem.description   = "Simple \"must\" matchers for specs."
  gem.summary       = "Adds \"must\" and \"must_not\" methods which can have matchers called upon them. Matchers can be added easily."
  gem.homepage      = "https://github.com/ryanb/musts"

  gem.files         = `git ls-files`.split($/)
  gem.test_files    = gem.files.grep(%r{^spec/})
  gem.require_paths = ["lib"]

  gem.add_development_dependency 'rake'
  gem.add_development_dependency 'rspec', '~> 2.12.0'
end
