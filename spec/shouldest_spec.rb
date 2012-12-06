require 'spec_helper'

describe Shouldest do
  it "raises an exception when match fails" do
    failure { 5.should.equal 4 }
  end

  it "does not raise an exception when match succeeds" do
    success { 5.should.equal 5 }
  end

  it "negates with should_not" do
    failure { 5.should_not.equal 5 }
    success { 5.should_not.equal 4 }
  end

  it "has a message when failing" do
    begin
      5.should.equal 4
    rescue Shouldest::Failure => exception
      exception.message.should.equal "Expected 5 to equal 4"
    end
  end

  it "has a negative message when failing" do
    begin
      5.should_not.equal 5
    rescue Shouldest::Failure => exception
      exception.message.should.equal "Expected 5 to not equal 5"
    end
  end

  def failure
    failed = false
    begin
      yield
    rescue Shouldest::Failure
      failed = true
    end
    raise "match did not fail" unless failed
  end

  def success
    failed = false
    begin
      yield
    rescue Shouldest::Failure
      failed = true
    end
    raise "match did fail" if failed
  end
end
