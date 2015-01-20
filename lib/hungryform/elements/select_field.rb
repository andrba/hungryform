module HungryForm
  module Elements
    class SelectField < Base::OptionsElement
      # Sets a value of the element
      # Checks the value from the resolver params against the available options
      def set_value
        if resolver.params.key?(name)
          self.value = resolver.params[name] if acceptable_values?
        else
          self.value = attributes.delete(:value)
        end
      end

      private

      # Check if all of the values from the resolver params are present
      # in the options.
      def acceptable_values?
        options_sym_keys = options.keys.map(&:to_sym)

        if @attributes[:multiple] && resolver.params[name].respond_to?(:map)
          (resolver.params[name].map(&:to_sym) - options_sym_keys).empty?
        else
          options_sym_keys.include?(resolver.params[name].to_sym)
        end
      end
    end
  end
end
