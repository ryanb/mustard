module Shouldest
  class Should
    def initialize(target, negate = false)
      @target = target
      @negate = negate
    end

    def equal(other)
      _assert(@target == other)
    end

  private

    def _assert(success)
      raise Shouldest::Failure if @negate && success || !@negate && !success
    end
  end
end
