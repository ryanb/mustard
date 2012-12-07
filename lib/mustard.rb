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

  matcher(:equal, :eq, :==)  { |other| self == other }
  matcher(:not_equal, :'!=') { |other| self != other }
  matcher(:match, :=~)       { |other| self =~ other }
  matcher(:be_true)    { self }
  matcher(:be_false)   { !self }
  matcher(:be_nil)     { nil? }
  matcher(:include)    { |*args| include?(*args) }
  matcher(:respond_to) { |*args| respond_to?(*args) }

  matcher(:be_greater_than, :be_gt)              { |other| self > other }
  matcher(:be_greater_than_or_equal_to, :be_gte) { |other| self >= other }
  matcher(:be_less_than, :be_lt)                 { |other| self < other }
  matcher(:be_less_than_or_equal_to, :be_lte)    { |other| self <= other }

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
