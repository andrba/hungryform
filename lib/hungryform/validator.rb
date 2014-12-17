module HungryForm
  module Validator
    class << self
      # Check if the element's value is not empty.
      # The rule argument can be a boolean or a callable object
      def required(element, rule)
        if rule.respond_to? :call
          rule.call(element)
        else
          'is required' if element.value.to_s.empty? && rule
        end
      end

      # Custom validation check
      # Use when you need to create a custom validation in the structure
      def validation(element, callable)
        unless callable.respond_to? :call
          fail HungryFormError 'Validation must respond to call'
        end

        callable.call(element)
      end
    end
  end
end
