module Shouldest
  class Should
    def initialize(target, negate = false)
      @target = target
      @negate = negate
    end

    def equal(other)
      _assert(@target == other, "equal #{other.inspect}")
    end

  private

    def _assert(success, message_action)
      if @negate && success || !@negate && !success
        message_action = "not " + message_action if @negate
        raise Shouldest::Failure.new("Expected #{@target.inspect} to #{message_action}")
      end
    end
  end
end
