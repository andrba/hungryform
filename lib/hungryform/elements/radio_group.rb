class HungryForm
  module Elements
    class RadioGroup < Base::OptionsElement
      # Sets a value of the element
      # Checks the value from the resolver params against the available options
      def set_value
        if resolver.params.key?(name)
          if options.keys.include?(resolver.params[name])
            self.value = resolver.params[name]
          end
        else
          self.value = @attributes[:value]
        end
      end
    end
  end
end
