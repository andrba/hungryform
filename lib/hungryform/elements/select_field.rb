module HungryForm
  module Elements
    class SelectField < Base::OptionsElement
      # Sets a value of the element
      # Checks the value from the resolver params against the available options
      def set_value
        if resolver.params.key?(name)
          options_sym_keys = options.keys.map(&:to_sym)

          # Check if all values present in the options
          if @attributes[:multiple] && resolver.params[name].respond_to?(:map)
            acceptable_values = (resolver.params[name].map(&:to_sym) - options_sym_keys).empty?
          else
            acceptable_values = options_sym_keys.include?(resolver.params[name].to_sym)
          end
          self.value = resolver.params[name] if acceptable_values
        else
          self.value = attributes.delete(:value)
        end
      end
    end
  end
end
