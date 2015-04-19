module HungryForm
  module Elements
    module Base
      # The ActiveElement class is used as a base class for all
      # form fields that can contain values and be validated
      class ActiveElement < Element
        attr_accessor :error, :value, :required
        alias_method :required?, :required

        hashable :required, :value, :error

        def initialize(name, parent, resolver, attributes = {}, &block)
          super

          clear_error

          if parent.visible?
            self.required = @attributes[:required] || false
          else
            self.required = false
          end

          # Determine validation attributes
          # They can be only the methods of the HungryForm::Validator class
          # or methods of the Validator module of the current class 
          methods = HungryForm::Validator.singleton_class.instance_methods(false)
          if self.class.const_defined?(:Validator)
            methods += self.class.const_get(:Validator).instance_methods(false)
          end

          @validation_rules = @attributes.select { |key, _| methods.include?(key) }
          @attributes.delete_if { |key, _| @validation_rules.key?(key) }

          set_value
        end

        # Element valid?
        # Performs element validation
        def valid?
          clear_error
          return true unless visible?

          @validation_rules.each do |key, rule|
            validate_rule(key, rule)

            unless error.empty?
              self.error = "This field #{error}"
              return false
            end
          end

          true
        end

        # Element invalid?
        # Performs elemen validation
        def invalid?
          !valid?
        end

        # Validate a particular validation rule
        # Searches for the validation attribute in the Validator module
        # of the element's class or in the global Validator module
        #
        # Sample:
        # text_field :txt, :required => true 
        # will search for the "required" singleton method
        # in the HungryForm::Elements::TextField::Validator and in the
        # HungryGorm::Validator 
        def validate_rule(attribute, rule)
          if self.class.const_defined?(:Validator)
            validator = self.class.const_get(:Validator)
          end
          
          if validator.nil? || !validator.singleton_class.instance_methods(false).include?(attribute)
            validator = HungryForm::Validator
          end

          self.error = validator.send(attribute, self, rule) || ''
        end

        def set_value
          self.value = resolver.params[name] || attributes.delete(:value)
        end

        def clear_error
          self.error = ''
        end
      end
    end
  end
end
