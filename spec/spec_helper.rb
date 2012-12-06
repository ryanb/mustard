require 'rubygems'
require 'bundler/setup'

require 'mustard'

RSpec.configure do |config|
  config.expect_with Mustard
end
