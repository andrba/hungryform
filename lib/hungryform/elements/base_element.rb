class HungryForm
  class BaseElement
    attr_accessor :visible, :name, :placeholders
    alias_method :visible?, :visible

    def initialize(name, options = {}, resolver)
      @name = name.to_s
      @resolver = resolver
      @visible = options.has_key?(:visible)? options[:visible] : true
    end
  end
end