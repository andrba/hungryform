class HungryForm
  # The BaseElement class is used in every form element. It contains the attrs
  # and methods used by all form elements, such as name, visible, dependency etc
  class BaseElement
    include HungryForm::Hashable
    attr_accessor :name, :placeholders, :resolver, :visible, :label, :dependency
    alias_method :visible?, :visible

    hashable :visible, :dependency, :name, :label

    def initialize(name, parent, resolver, attributes = {})
      @attributes = attributes.dup

      @placeholders ||= {}
      @resolver = resolver

      self.dependency ||= @attributes[:dependency]

      # The element is visible if no visible parameter passed or
      # visible param equals true and the dependency is resolved positively
      self.visible = @attributes.key?(:visible) ? @attributes[:visible] : true

      if dependency
        json_dependency = ::JSON.parse(dependency)
        self.visible &&= resolver.resolve_dependency(json_dependency)
      end

      # An element's name is prefixed with all parents names up to the page
      self.name = resolver.get_value(name, self)
      self.name = "#{parent.name}_#{name}" unless parent.nil?

      # Label can be created from name if there is no label given
      if @attributes[:label]
        self.label = resolver.get_value(@attributes[:label], self)
      else
        self.label = resolver.get_value(name, self).humanize
      end
    end

    def method_missing(method_name, *args, &block)
      # Check if an option exists
      if method_name.to_s[-1] == '?'
        return @attributes.key?(method_name.to_s[0..-2].to_sym)
      end

      # Return an attribute
      return @attributes[method_name] if @attributes.key?(method_name)
      super
    end

    def respond_to_missing?(method_name, include_private = false)
      @attributes.key?(method_name) || super
    end
  end
end
