class HungryForm
  class SelectField < BaseOptionsElement
  	attr_accessor :multiple
  	alias_method :multiple?, :multiple

  	def initialize(name, parent, resolver, options = {}, &block)
  		super
      self.multiple = @_options[:multiple] || false
		end

		# Sets a value of the element
    # Checks the value from the resolver params against the available options
    def set_value
      if resolver.params.has_key?(self.name)
      	
      	# Check if all values present in the options
      	if self.multiple?
      		acceptable_values = (resolver.params[self.name] - self.options.keys).empty?
    		else
    		 	acceptable_values = self.options.keys.include?(resolver.params[self.name])
  		 	end

      	self.value = resolver.params[self.name] if acceptable_values
      else
        self.value = @_options[:value]
      end
    end
  end
end