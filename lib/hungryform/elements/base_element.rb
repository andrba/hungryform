class HungryForm
  class BaseElement < ::Hashie::Mash
    attr_accessor :name, :placeholders

    def initialize(name, options = {}, resolver)
    	self.placeholders = {}
      self.name = resolver.get_value(name, self)
      @resolver = resolver

      super(options)

      self.visible = options.has_key?(:visible)? options[:visible] : true
    end
  end
end