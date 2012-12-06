module Shouldest
  module ObjectExtension
    def should
      Should.new(self)
    end
  end
end

Object.send(:include, Shouldest::ObjectExtension)
