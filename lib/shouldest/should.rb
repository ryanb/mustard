module Shouldest
  class Should
    def initialize(target)
      @target = target
    end

    def equal(other)
      raise Shouldest::Failure unless @target == other
    end
  end
end
