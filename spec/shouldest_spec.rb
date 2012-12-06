require 'spec_helper'

describe Shouldest do
  it "raises an exception when match fails" do
    failure { 5.should.equal 4 }
  end

  it "does not raise an exception when match succeeds" do
    success { 5.should.equal 5 }
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
