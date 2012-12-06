require 'spec_helper'

describe Shouldest do
  it "raises an exception when match fails" do
    failure { 5.should.equal 4 }
  end

  it "does not raise an exception when match succeeds" do
    5.should.equal 5
  end

  it "negates with should_not" do
    failure { 5.should_not.equal 5 }
    5.should_not.equal 4
  end

  it "has a message when failing" do
    failure("Expected 5 to equal 4") { 5.should.equal 4 }
    failure("Expected 5 to not equal 5") { 5.should_not.equal 5 }
    failure('Expected "5" to equal "4"') { "5".should.equal "4" }
  end

  it "adds custom matcher" do
    Shouldest.matcher(:be_empty) { empty? }
    [].should.be_empty
    failure('Expected [1] to be empty') { [1].should.be_empty }
  end

  it "adds custom matcher with alias" do
    Shouldest.matcher(:be_empty, :be_vacant) { empty? }
    failure('Expected [1] to be empty') { [1].should.be_vacant }
  end

  it "has eq matcher" do
    5.should.eq 5
    failure("Expected 5 to equal 4") { 5.should.eq 4 }
  end

  it "has be_greater_than matcher" do
    5.should.be_greater_than 4
    failure("Expected 5 to be greater than 5") do
      5.should.be_greater_than 5
    end
    failure("Expected 5 to be greater than 5") do
      5.should.be_gt 5
    end
  end

  it "has be_greater_than_or_equal_to matcher" do
    5.should.be_greater_than_or_equal_to 5
    failure("Expected 5 to be greater than or equal to 6") do
      5.should.be_greater_than_or_equal_to 6
    end
    failure("Expected 5 to be greater than or equal to 6") do
      5.should.be_gte 6
    end
  end

  it "has be_less_than matcher" do
    5.should.be_less_than 6
    failure("Expected 5 to be less than 5") do
      5.should.be_less_than 5
    end
    failure("Expected 5 to be less than 5") do
      5.should.be_lt 5
    end
  end

  it "has be_less_than_or_equal_to matcher" do
    5.should.be_less_than_or_equal_to 5
    failure("Expected 5 to be less than or equal to 4") do
      5.should.be_less_than_or_equal_to 4
    end
    failure("Expected 5 to be less than or equal to 4") do
      5.should.be_lte 4
    end
  end

  it "has be matcher" do
    [].should.be :empty?
    failure("Expected [1] to be :empty?") do
      [1].should.be :empty?
    end
    failure("Expected 3 to be :between?, 4, 6") do
      3.should.be :between?, 4, 6
    end
  end

  it "has be_true/false/nil matchers" do
    true.should.be_true
    false.should.be_false
    1.should.be_true
    nil.should.be_false
    nil.should.be_nil
    failure("Expected false to be true") do
      false.should.be_true
    end
    failure("Expected true to be false") do
      true.should.be_false
    end
    failure("Expected false to be nil") do
      false.should.be_nil
    end
  end

  it "has include matcher" do
    [1, 2, 3].should.include 3
    failure("Expected [1, 2, 3] to include 4") do
      [1, 2, 3].should.include 4
    end
  end

  it "has raise_exception matcher" do
    -> { raise "foo" }.should.raise_exception
    -> { raise Shouldest::Failure }.should.raise_exception(Shouldest::Failure)
    failure { -> { nil }.should.raise_exception }
  end

  def failure(message = nil)
    failed = false
    begin
      yield
    rescue Shouldest::Failure => exception
      failed = true
      exception.message.should.equal message if message
    end
    raise "match did not fail" unless failed
  end
end
