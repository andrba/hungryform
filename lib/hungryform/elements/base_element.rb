class HungryForm
  class BaseElement
    attr_accessor :name, :placeholders, :resolver, :visible, :label, :dependency
    alias_method :visible?, :visible

    def initialize(name, parent, resolver, attributes = {})
      @attributes = attributes.dup

      @placeholders ||= {}
      @resolver = resolver

      # The element is visible if no visible parameter passed or
      # visible param equals true and the dependency is resolved positively
      self.visible = @attributes.has_key?(:visible)? @attributes[:visible] : true
      self.visible &&= resolver.resolve_dependency(::JSON.parse(@attributes[:dependency])) if @attributes[:dependency]
      self.dependency = @attributes[:dependency] || ''
      self.name = (parent.nil?? "" : "#{parent.name}_") + resolver.get_value(name, self)

      unless @attributes[:label]
        self.label = resolver.get_value(name, self).humanize
      else
        self.label = resolver.get_value(@attributes[:label], self)
      end
    end

    def method_missing(name, *args, &block)
      # Check if an option exists
      return @attributes.has_key?(name.to_s[0..-2].to_sym) if name.to_s[-1] == '?'
      # Return an option
      return @attributes[name] if @attributes.has_key?(name)
      super
    end
  end
end