module Shouldest
  class Should
    def initialize(target)
      @target = target
    end

    def equal(other)
      raise Shouldest::Failure
    end
  end
end
