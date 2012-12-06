module Shouldest
  module ObjectExtension
    def should
      Should.new(self)
    end

    def should_not
      Should.new(self, true)
    end
  end
end

Object.send(:include, Shouldest::ObjectExtension)
