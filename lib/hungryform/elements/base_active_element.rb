class HungryForm
  class BaseActiveElement < BaseElement
    
    attr_accessor :error, :value, :required
    alias_method :required?, :required

    hashable :required, :value, :error

    def initialize(name, parent, resolver, attributes = {}, &block)
      super

      self.error = ''

      # Filter only the attributes that are present in the HungryForm::Validator singleton class
      @validation_rules = @attributes.select { |key, val| HungryForm::Validator.respond_to?(key) }

      if parent.visible?
        self.required = @attributes[:required] || false
      else
        self.required = false 
      end

      set_value()
    end

    def valid?
      self.error = ''

      return true if !visible?

      is_valid = true

      @validation_rules.each do |key, rule|
        error = HungryForm::Validator.send(key, self, rule) || ''
        unless error.empty?
          is_valid = false
          break
        end
      end

      is_valid
    end

    def set_value
      self.value = resolver.params.has_key?(name)? resolver.params[name] : @attributes[:value]
    end
    
  end
end