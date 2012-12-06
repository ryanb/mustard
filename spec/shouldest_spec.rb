require 'spec_helper'

describe Shouldest do
  it "raises an exception when match fails" do
    failed = false
    begin
      5.should.equal 4
    rescue Shouldest::Failure
      failed = true
    end
    raise "match did not fail" unless failed
  end
end
