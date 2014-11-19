class HungryForm
  class BaseOptionsElement < BaseActiveElement

    attr_accessor :options

    def initialize(name, parent, resolver, options = {}, &block)
      super

      if options.has_key?(:options)
        self.options = options[:options]
      else
        raise HungryFormException, "No options provided for #{name}"
      end

      unless self.options.kind_of?(Hash)
        self.options = resolver.get_value(self.options, self)
      end
    end
  end
end