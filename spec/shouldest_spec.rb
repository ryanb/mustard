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
    failure("Expected 5 to equal 4") { 5.should.equal 4 }
    failure("Expected 5 to not equal 5") { 5.should_not.equal 5 }
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
