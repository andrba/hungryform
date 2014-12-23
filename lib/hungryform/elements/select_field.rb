module HungryForm
  module Elements
    class SelectField < Base::OptionsElement
      # Sets a value of the element
      # Checks the value from the resolver params against the available options
      def set_value
        if resolver.params.key?(name)

          # Check if all values present in the options
          if @attributes[:multiple]
            acceptable_values = (resolver.params[name] - options.keys).empty?
          else
            acceptable_values = options.keys.include?(resolver.params[name])
          end

          self.value = resolver.params[name] if acceptable_values
        else
          self.value = attributes.delete(:value)
        end
      end
    end
  end
end
