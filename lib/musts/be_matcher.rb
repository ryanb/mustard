module Musts
  class BeMatcher
    def initialize(subject, method, *args)
      @subject = subject
      @method = method
      @args = args
    end

    def match?
      @subject.send(@method, *@args)
    end

    def failure_message
      "Expected #{@subject.inspect} to be #{message_action}"
    end

    def negative_failure_message
      "Expected #{@subject.inspect} to not be #{message_action}"
    end

    def message_action
      message_action = @method.to_s.sub(/\?$/, "")
      message_action += " " + @args.map(&:inspect).join(" and ") unless @args.empty?
      message_action
    end
  end
end
