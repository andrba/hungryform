class HungryForm
  class BaseGroup < BaseElement
    attr_accessor :elements

    def initialize(name, options = {}, resolver, &block)
      super
      @elements = []
      instance_eval(&block)
    end

    def method_missing(name, *args, &block)
      #Find a matching class
      klass = HungryForm.constants.find {|c| Class === HungryForm.const_get(c) && c.to_s.underscore.to_sym == name}
      return super if klass.nil?

      element = HungryForm::const_get(klass).new(*args, @resolver, &block)
      elements << element
      #Resolver keeps a hash of all elements of the form
      @resolver.elements[element.name] = element
      element
    end
  end
end