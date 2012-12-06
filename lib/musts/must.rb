module Musts
  class Must
    def self.matcher(name, *other_names, &block)
      define_method(name) do |*args|
        result = @target.instance_exec(*args, &block)
        _assert(result, name, args)
      end
      other_names.each do |other_name|
        alias_method other_name, name
      end
    end

    def initialize(target, negate = false)
      @target = target
      @negate = negate
    end

    matcher(:equal, :eq) { |other| self == other }
    matcher(:be_greater_than, :be_gt) { |other| self > other }
    matcher(:be_greater_than_or_equal_to, :be_gte) { |other| self >= other }
    matcher(:be_less_than, :be_lt) { |other| self < other }
    matcher(:be_less_than_or_equal_to, :be_lte) { |other| self <= other }
    matcher(:be) { |method, *args| send(method, *args) }
    matcher(:be_true) { self }
    matcher(:be_false) { !self }
    matcher(:be_nil) { nil? }
    matcher(:include) { |*args| include?(*args) }

    matcher(:raise_exception) do |*args|
      raised = false
      exception = args.first || StandardError
      begin
        call
      rescue exception
        raised = true
      end
      raised
    end

  private

    def _assert(success, name, args)
      if @negate && success || !@negate && !success
        message_action = name.to_s.tr("_", " ")
        message_action = "not " + message_action if @negate
        message_action += " " + args.map(&:inspect).join(", ") unless args.empty?
        raise Musts::Failure.new("Expected #{@target.inspect} to #{message_action}")
      end
    end
  end
end
