require "musts/version"
require "musts/object_extension"
require "musts/must"

module Musts
  class Failure < StandardError; end

  def self.matcher(*args, &block)
    Must.matcher(*args, &block)
  end
end
