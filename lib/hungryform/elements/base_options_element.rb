class HungryForm
  class BaseOptionsElement < BaseActiveElement

    attr_accessor :options

    def initialize(name, parent, resolver, options = {}, &block)
      if options.has_key?(:options)
        self.options = options[:options]
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
      if resolver.params.has_key?(self.name) && self.options.has_key?(resolver.params[self.name])
        self.value = resolver.params[self.name]
      else
        self.value = @_options[:value]
      end
    end
  end
end