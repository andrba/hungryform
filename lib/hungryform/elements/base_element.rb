class HungryForm
  class BaseElement
    include HungryForm::Hashable
    attr_accessor :name, :placeholders, :resolver, :visible, :label, :dependency
    alias_method :visible?, :visible

    hashable :visible, :dependency, :name, :label

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

    def to_json
      JSON.generate({
        self.name => self.to_hash.merge({ :_type => self.class.name.demodulize })
      })
    end

    def method_missing(method_name, *args, &block)
      # Check if a method or an option exists
      if method_name.to_s[-1] == '?'
        signless_method_name = method_name.to_s[0..-2]
        return respond_to?(signless_method_name) || @attributes.has_key?(signless_method_name)
      end

      # Return an attribute
      return @attributes[method_name] if @attributes.has_key?(method_name)
      super
    end

    def respond_to_missing?(method_name, include_private = false)
      @attributes.has_key?(method_name) || super
    end
  end
end