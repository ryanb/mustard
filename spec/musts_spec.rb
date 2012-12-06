require 'spec_helper'

describe Musts do
  it "fails when calling fail with message" do
    failure { fail }
    failure("something went wrong") { fail "something went wrong" }
  end

  it "raises an exception when match fails" do
    failure { 5.must.equal 4 }
  end

  it "raises an RSpec::Musts::Failure exception in RSpec" do
    -> { 5.must.eq 4 }.must.raise_exception(RSpec::Musts::Failure)
  end

  it "does not raise an exception when match succeeds" do
    5.must.equal 5
  end

  it "negates with must_not" do
    failure { 5.must_not.equal 5 }
    5.must_not.equal 4
  end

  it "has a message when failing" do
    failure("expected 5 to equal 4") { 5.must.equal 4 }
    failure("expected 5 to not equal 5") { 5.must_not.equal 5 }
    failure('expected "5" to equal "4"') { "5".must.equal "4" }
  end

  it "adds custom matcher" do
    Musts.matcher(:be_empty) { empty? }
    [].must.be_empty
    failure('expected [1] to be empty') { [1].must.be_empty }
  end

  it "adds custom matcher with alias" do
    Musts.matcher(:be_empty, :be_vacant) { empty? }
    failure('expected [1] to be empty') { [1].must.be_vacant }
  end

  it "has eq matcher" do
    5.must.eq 5
    failure("expected 5 to equal 4") { 5.must.eq 4 }
  end

  it "has be_greater_than matcher" do
    5.must.be_greater_than 4
    failure("expected 5 to be greater than 5") do
      5.must.be_greater_than 5
    end
    failure("expected 5 to be greater than 5") do
      5.must.be_gt 5
    end
  end

  it "has be_greater_than_or_equal_to matcher" do
    5.must.be_greater_than_or_equal_to 5
    failure("expected 5 to be greater than or equal to 6") do
      5.must.be_greater_than_or_equal_to 6
    end
    failure("expected 5 to be greater than or equal to 6") do
      5.must.be_gte 6
    end
  end

  it "has be_less_than matcher" do
    5.must.be_less_than 6
    failure("expected 5 to be less than 5") do
      5.must.be_less_than 5
    end
    failure("expected 5 to be less than 5") do
      5.must.be_lt 5
    end
  end

  it "has be_less_than_or_equal_to matcher" do
    5.must.be_less_than_or_equal_to 5
    failure("expected 5 to be less than or equal to 4") do
      5.must.be_less_than_or_equal_to 4
    end
    failure("expected 5 to be less than or equal to 4") do
      5.must.be_lte 4
    end
  end

  it "has be matcher" do
    [].must.be :empty?
    failure("expected [1] to be empty") do
      [1].must.be :empty?
    end
    failure("expected 3 to be between 4 and 6") do
      3.must.be :between?, 4, 6
    end
  end

  it "has be_true/false/nil matchers" do
    true.must.be_true
    false.must.be_false
    1.must.be_true
    nil.must.be_false
    nil.must.be_nil
    failure("expected false to be true") do
      false.must.be_true
    end
    failure("expected true to be false") do
      true.must.be_false
    end
    failure("expected false to be nil") do
      false.must.be_nil
    end
  end

  it "has include matcher" do
    [1, 2, 3].must.include 3
    failure("expected [1, 2, 3] to include 4") do
      [1, 2, 3].must.include 4
    end
  end

  it "has match matcher" do
    "foobar".must.match /foo/
    failure("expected \"foo\" to match /bar/") do
      "foo".must.match /bar/
    end
  end

  it "has respond_to matcher" do
    "foobar".must.respond_to :length
    failure("expected \"foo\" to respond to :invalid_method") do
      "foo".must.respond_to :invalid_method
    end
  end

  it "has be_close_to matcher" do
    5.00001.must.be_close_to 5.0
    failure("expected 5.01 to be within 0.001 of 5.0") do
      5.01.must.be_close_to 5.0
    end
    failure("expected 6.0 to be within 0.1 of 5.0") do
      6.0.must.be_close_to 5.0, 0.1
    end
  end

  it "has raise_exception matcher" do
    -> { raise "foo" }.must.raise_exception
    -> { raise Musts::Failure }.must.raise_exception(Musts::Failure)
    failure { -> { nil }.must.raise_exception }
  end

  it "allows custom class for matcher" do
    matcher_class = Struct.new(:subject, :other) do
      def match?
        subject == other
      end

      def failure_message
        "failure message"
      end

      def negative_failure_message
        "negative failure message"
      end
    end

    Musts.matcher(:be_equal, matcher_class)
    5.must.be_equal 5
    failure("failure message") { 5.must.be_equal 4 }
    failure("negative failure message") { 5.must_not.be_equal 5 }
  end

  def failure(message = nil)
    failed = false
    begin
      yield
    rescue Musts::Failure => exception
      failed = true
      exception.message.must.equal message if message
    end
    raise "match did not fail" unless failed
  end
end
