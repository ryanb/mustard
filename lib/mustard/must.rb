module Mustard
  class Must
    def self.matcher(name, *other_names, &block)
      if block
        matcher_class = DefaultMatcher.subclass_for(name, block)
      else
        matcher_class = other_names.pop
      end
      define_method(name) do |*args|
        _assert matcher_class.new(@subject, *args)
      end
      other_names.each do |other_name|
        alias_method other_name, name
      end
    end

    def initialize(subject, negate = false)
      @subject = subject
      @negate = negate
    end

  private

    def _assert(matcher)
      if @negate == !!matcher.match?
        message = @negate ? matcher.negative_failure_message : matcher.failure_message
        Mustard.fail(message)
      end
    end
  end
end
