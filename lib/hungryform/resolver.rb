class HungryForm
  # The class is responsible for dependency resolving.
  # It contains all form elements and params
  class Resolver
    attr_accessor :elements, :params

    def initialize(options = {})
      @params = options[:params] || {}
      @elements = {}
    end

    # Gets element value by element's name.
    # If name is lambda - returns lambda's result
    # If name is present in the resolvers' elements hash - returns element's value
    # If name is present in the resolvers' params hash - returns params value
    # Otherwise returns the argument without changes
    def get_value(name, element = nil)
      return name.call(element) if name.respond_to? :call

      # We don't want to mess up elements names
      name = name.to_s.dup

      # Apply placeholders to the name.
      # A sample name string can look like this: page1_group[GROUP_NUMBER]_field
      # where [GROUP_NUMBER] is a placeholder. When an element is present
      # we get its placeholders and replace substrings in the name argument
      element.placeholders.each { |k, v| name[k] &&= v } if element

      return @elements[name].value if @elements.key?(name)
      return @params[name] if @params.key?(name)

      name
    end

    # Gets dependency rules hash and returns true or false depending on
    # the result of a recursive processing of the rules
    def resolve_dependency(dependency)
      dependency.each do |operator, arguments|
        case operator
        when 'AND'
          return resolve_multi_dependency(:and, arguments)
        when 'OR'
          return resolve_multi_dependency(:or, arguments)
        when 'NOT'
          return !resolve_dependency(arguments)
        end

        arguments = [arguments] unless arguments.is_a?(Array)

        arguments = arguments[0..1].map { |name| get_value(name) }
        return false if arguments.any?(&:nil?)

        case operator
        when 'EQ'
          return arguments[0].to_s == arguments[1].to_s
        when 'LT'
          return arguments[0].to_f < arguments[1].to_f
        when 'GT'
          return arguments[0].to_f > arguments[1].to_f
        when 'SET'
          return !arguments[0].empty?
        end
      end
    end

    private

    def resolve_multi_dependency(type, arguments)
      if arguments.size == 0
        fail HungryFormException, "No arguments for #{type.upcase} comparison: #{arguments}"
      end

      result = type == :and

      arguments.each do |argument|
        return !result unless resolve_dependency(argument)
      end

      result
    end
  end
end
