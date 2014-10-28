class HungryForm
  class Html < BaseElement
    attr_reader :value 

    def initialize(name, options = {}, resolver, &block)
      super
      @value = options.has_key?(:value)? resolver.get_value(options[:value]) : ""
    end
  end
end