module HungryForm
  module Elements
    class CheckboxField < Base::ActiveElement
      def set_value
        self.value = resolver.params[name] || attributes.delete(:value) || 0

        if value.to_i == 0
          attributes.delete(:checked)
        else
          self.value = 1
          self.attributes[:checked] = true
        end
      end

      def checked?
        !!attributes[:checked]
      end

      # Overriding the Validator methods
      module Validator
        def self.required(element, rule)
          if rule.respond_to? :call
            rule.call(element)
          else
            'is required' if element.value == 0 && rule
          end
        end
      end
    end
  end
end
