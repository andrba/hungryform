class HungryForm
  class BaseElement < ::Hashie::Mash
    attr_accessor :name, :placeholders, :resolver

    def initialize(name, parent, resolver, options = {})
    	self.placeholders ||= {}
      self.resolver = resolver

      super(options)

      self.visible = true unless self.key?(:visible)
      self.visible &&= resolver.resolve_dependency(::JSON.parse(self.dependency)) if self.key?(:dependency)
      self.name = (parent.nil?? "" : "#{parent.name}_") + resolver.get_value(name, self)

      if self.key?(:label)
      	self.label = resolver.get_value(self.label, self)
    	else
    		self.label = resolver.get_value(name, self).humanize
  		end
    end
  end
end