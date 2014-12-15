class HungryForm
  class BaseOptionsElement < BaseActiveElement
    attr_accessor :options

    hashable :options

    def initialize(name, parent, resolver, attributes = {}, &block)
      if attributes.has_key?(:options)
        self.options = attributes[:options].dup
      else
        raise HungryFormException, "No options provided for #{name}"
      end

      unless self.options.kind_of?(Hash)
        self.options = resolver.get_value(self.options, self)
      end

      super
    end

    # Sets a value of the element
    # Checks the value from the resolver params against the available options
    def set_value
      if resolver.params.has_key?(name) && options.has_key?(resolver.params[name])
        self.value = resolver.params[name]
      else
        self.value = @attributes[:value]
      end
    end
  end
end