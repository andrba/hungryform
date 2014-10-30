class HungryForm
  class BaseActiveElement < BaseElement
  	attr_reader :error

    def initialize(name, parent_name, options = {}, resolver, &block)
      super
      self.error = ''
    end

    def valid?
    	return true if !visible?

			if required? && value.to_s.empty?
				error = "This field is required"
			elsif validation?
				#Validation rules string delimited with pipe symbols
				if validation.is_a? String 
					process_validation_string(validation)
				#Anonimous validation function
				elsif validation.respond_to? :call
					error = validation.call(self, resolver) || ''
				end
			end

			error.empty?
  	end
  end
end