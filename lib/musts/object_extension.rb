module Musts
  module ObjectExtension
    def must
      Must.new(self)
    end

    def must_not
      Must.new(self, true)
    end
  end
end

Object.send(:include, Musts::ObjectExtension)
