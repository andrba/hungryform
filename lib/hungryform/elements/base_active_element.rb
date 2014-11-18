class HungryForm
  class BaseActiveElement < BaseElement
    attr_accessor :error

    def initialize(name, parent, resolver, options = {}, &block)
      super
      self.error = ''

      # Filter only the options that are present in the HungryForm::Validator singleton class
      @validation_rules = options.select { |key, val| HungryForm::Validator.respond_to?(key) }

      self.required = false unless parent.visible?
      self.value = resolver.params[self.name] if resolver.params.has_key?(self.name)
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

    
  end
end