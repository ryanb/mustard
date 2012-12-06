require "rubygems"
require "minitest/autorun"
require "musts"

describe Musts::Failure do
  it "inherits from MiniTest::Assertion" do
    (Musts::Failure < MiniTest::Assertion).must.be_true
  end
end
