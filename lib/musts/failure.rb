module Musts
  if defined?(MiniTest::Assertion)
    class Failure < MiniTest::Assertion; end
  elsif defined?(Test::Unit::AssertionFailedError)
    class Failure < Test::Unit::AssertionFailedError; end
  else
    class Failure < StandardError; end
  end
end

# Kind of silly but the failure class must start with "RSpec"
# for it to not show up in RSpec output.
if defined?(RSpec)
  module RSpec
    module Musts
      class Failure < ::Musts::Failure; end
    end
  end
end
