module Musts
  class Must
    def self.matcher(name, *other_names, &block)
      define_method(name) do |*args|
        result = @subject.instance_exec(*args, &block)
        _assert(result, name, args)
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

    def _assert(success, name, args)
      if @negate && success || !@negate && !success
        message_action = name.to_s.tr("_", " ")
        message_action = "not " + message_action if @negate
        message_action += " " + args.map(&:inspect).join(", ") unless args.empty?
        raise Musts::Failure.new("Expected #{@subject.inspect} to #{message_action}")
      end
    end
  end
end
