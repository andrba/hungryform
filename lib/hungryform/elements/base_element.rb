class HungryForm
  class BaseElement < ::Hashie::Mash
    attr_accessor :name, :placeholders, :resolver

    def initialize(name, parent_name, options = {}, resolver)
    	self.placeholders ||= {}
      self.resolver = resolver

      super(options)

      self.visible = true if !self.key?(:visible)
      self.name = "#{parent_name}_" + resolver.get_value(name, self)

      if self.key?(:label)
      	self.label = resolver.get_value(self.label, self)
    	else
    		self.label = resolver.get_value(name, self).humanize
  		end
    end
  end
end