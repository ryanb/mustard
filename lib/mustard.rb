require "mustard/version"
require "mustard/object_extension"
require "mustard/failure"
require "mustard/must"
require "mustard/matchers/default_matcher"
require "mustard/matchers/be_matcher"
require "mustard/matchers/close_matcher"
require "mustard/matchers/have_matcher"

module Mustard
  def self.matcher(*args, &block)
    Must.matcher(*args, &block)
  end

  def self.matcher_alias(method, *aliases)
    Must.matcher(*aliases) do |*args|
      self.send(method, *args)
    end
  end

  def self.fail(message = nil)
    if defined?(RSpec::Mustard::Failure)
      raise RSpec::Mustard::Failure.new(message)
    else
      raise Failure.new(message)
    end
  end

  def fail(*args)
    Mustard.fail(*args)
  end

  matcher(:be_true)  { self }
  matcher(:be_false) { !self }

  matcher_alias(:==, :equal, :eq)
  matcher_alias(:=~, :match)
  matcher_alias(:nil?, :be_nil)

  matcher_alias(:include?, :include)
  matcher_alias(:respond_to?, :respond_to)

  matcher_alias(:>,  :be_greater_than, :be_gt)
  matcher_alias(:>=, :be_greater_than_or_equal_to, :be_gte)
  matcher_alias(:<,  :be_less_than, :be_lt)
  matcher_alias(:<=, :be_less_than_or_equal_to, :be_lte)

  matcher(:be, BeMatcher)
  matcher(:be_close_to, CloseMatcher)

  matcher(:have, HaveMatcher)

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
end
