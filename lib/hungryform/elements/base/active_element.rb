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

          # Leave only the attributes that are being methods of the HungryForm::Validator class
          @validation_rules = @attributes.select { |key, _| HungryForm::Validator.singleton_class.instance_methods(false).include?(key) }
          @attributes.delete_if { |key, _| @validation_rules.key?(key) }

          set_value
        end

        def valid?
          clear_error
          is_valid = true
          return true unless visible?

          @validation_rules.each do |key, rule|
            self.error = HungryForm::Validator.send(key, self, rule) || ''
            unless error.empty?
              self.error = "This field #{error}"
              is_valid = false
              break
            end
          end

          is_valid
        end

        def invalid?
          !valid?
        end

        def set_value
          self.value = resolver.params.key?(name) ? resolver.params[name] : attributes.delete(:value)
        end

        def clear_error
          self.error = ''
        end
      end
    end
  end
end
