class HungryForm
  class BaseActiveElement < BaseElement
  	attr_accessor :error

    def initialize(name, parent_name, options = {}, resolver, &block)
      super
      self.error = ''
      @validation_rules = options.select { |key, val| HungryForm::Validator.method_defined?(key) }
    end

    def valid?
    	self.error = ''

    	return true if !visible?

    	is_valid = true
    	# puts 
    	@validation_rules.each do |key, rule|
    		error = HungryForm::Validator.send(key, self, rule) || ''
    		if error.any?
    			is_valid = false
    			break
  			end
  		end

  		is_valid
  	end
  end
end