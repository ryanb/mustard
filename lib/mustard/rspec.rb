require 'mustard'

module Mustard

  # Public: Module to include in all example groups to make the implicit subject
  # the target of Mustard assertions.
  #
  module RSpecExtension
    def must
      Must.new(subject)
    end

    def must_not
      Must.new(subject, true)
    end
  end

end

RSpec.configure do |config|
  config.expect_with Mustard
  config.include Mustard::RSpecExtension
end
