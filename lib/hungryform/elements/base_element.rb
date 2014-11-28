class HungryForm
  class BaseElement
    attr_accessor :name, :placeholders, :resolver, :visible, :label, :dependency
    alias_method :visible?, :visible

    def initialize(name, parent, resolver, options = {})
      @_options = options.dup

      @placeholders ||= {}
      @resolver = resolver

      # The element is visible if no visible parameter passed or
      # visible param equals true and the dependency is resolved positively
      self.visible = options.has_key?(:visible)? options[:visible] : true
      self.visible &&= resolver.resolve_dependency(::JSON.parse(options[:dependency])) if options[:dependency]
      self.dependency = options[:dependency] || ''
      self.name = (parent.nil?? "" : "#{parent.name}_") + resolver.get_value(name, self)

      unless options[:label]
        self.label = resolver.get_value(name, self).humanize
      else
        self.label = resolver.get_value(options[:label], self)
      end
    end

    def method_missing(name, *args, &block)
      # Check if an option exists
      return @_options.has_key?(name.to_s[0..-2].to_sym) if name.to_s[-1] == '?'
      # Return an option
      return @_options[name] if @_options.has_key?(name)
      super
    end
  end
end