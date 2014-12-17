module HungryForm
  module Elements::Base
    # The BaseOptionsElement class can be used as a base class for
    # fields with options, such as select or radio
    class OptionsElement < ActiveElement
      attr_accessor :options

      hashable :options

      def initialize(name, parent, resolver, attributes = {}, &block)
        if attributes.key?(:options)
          self.options = attributes[:options].dup
        else
          fail HungryFormException, "No options provided for #{name}"
        end

        unless options.is_a?(Hash)
          self.options = resolver.get_value(options, self)
        end

        super
      end

      # Sets a value of the element
      # Checks the value from the resolver params against the available options
      def set_value
        if resolver.params.key?(name) && options.key?(resolver.params[name])
          self.value = resolver.params[name]
        else
          self.value = @attributes[:value]
        end
      end
    end
  end
end
