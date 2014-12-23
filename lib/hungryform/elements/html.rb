module HungryForm
  module Elements
    class Html < Base::Element
      attr_accessor :value
      hashable :value

      def initialize(name, parent, resolver, attributes = {}, &block)
        super
        self.value = @attributes.delete(:value) || ''
      end
    end
  end
end
