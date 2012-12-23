module Mustard
  module ObjectExtension
    def must
      Must.new(self)
    end

    def must_not
      Must.new(self, true)
    end
  end

  module RSpecExtension
    def must
      Must.new(subject)
    end

    def must_not
      Must.new(subject, true)
    end
  end
end

Object.send(:include, Mustard::ObjectExtension)
