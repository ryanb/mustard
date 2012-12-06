require "shouldest/version"
require "shouldest/object_extension"
require "shouldest/should"

module Shouldest
  class Failure < StandardError; end

  def self.matcher(*args, &block)
    Should.matcher(*args, &block)
  end
end
