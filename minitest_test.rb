require "rubygems"
require "minitest/autorun"
require "mustard"

describe Mustard::Failure do
  it "inherits from MiniTest::Assertion" do
    (Mustard::Failure < MiniTest::Assertion).must.be_true
  end
end
