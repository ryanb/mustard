require 'rubygems'
require 'bundler/setup'

require 'musts'

RSpec.configure do |config|
  config.expect_with Musts
end
