module Musts
  class CloseMatcher
    def initialize(subject, expected, delta = 0.001)
      @subject = subject
      @expected = expected
      @delta = delta
    end

    def match?
      @delta >= (@subject - @expected).abs
    end

    def failure_message
      "expected #{@subject.inspect} to #{message_expected}"
    end

    def negative_failure_message
      "expected #{@subject.inspect} to not #{message_expected}"
    end

    def message_expected
      "be within #{@delta.inspect} of #{@expected.inspect}"
    end
  end
end
