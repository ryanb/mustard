module Musts
  class DefaultMatcher
    # This will genereate a subclass of DefaultMatcher to
    # act as the matcher class. This way we can persist the
    # name of the matcher and the block of behavior.
    def self.subclass_for(name, behavior)
      klass = Class.new(self)
      class << klass
        attr_accessor :name, :behavior
      end
      klass.name = name
      klass.behavior = behavior
      klass
    end

    def initialize(subject, *args)
      @subject = subject
      @args = *args
    end

    def match?
      @subject.instance_exec(*@args, &self.class.behavior)
    end

    def failure_message
      "expected #{@subject.inspect} to #{message_action}"
    end

    def negative_failure_message
      "expected #{@subject.inspect} to not #{message_action}"
    end

    def message_action
      message_action = self.class.name.to_s.tr("_", " ")
      message_action += " " + @args.map(&:inspect).join(", ") unless @args.empty?
      message_action
    end
  end
end
