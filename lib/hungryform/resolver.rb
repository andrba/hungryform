class HungryForm
  class Resolver
    attr_accessor :elements

    def initialize(options = {})
      @params = options[:params] || {}
      @elements = {}
    end

    # Gets element value by element name. 
    # If name is lambda - returns lambda's result
    # If name is present in the elements hash - returns element's value
    # Otherwise returns name
    def get_value(name, element = nil)
      return name.call(element) if name.respond_to? :call

      name = name.to_s.dup
      
      #apply placeholders
      if element
        element.placeholders.each { |k, v| name[k] &&= v }
      end

      return name if !elements.has_key?(name)
      elements[name].value
    end

    def resolve_dependency(dependency)
      # dependency.each do |operator, arguments|
      #   raise HungryFormException, "Arguments must be of an array type: #{arguments}" if !arguments.is_a?(Array)

      #   case operator
      #   when 'EQ' 
      #     is_equal? arguments
      #   when 'LT'
      #     is_less_than? arguments
      #   when 'GT'
      #     is_greater_than? arguments
      #   when 'NOT'
      #     !resolve_dependency(arguments)
      #   when 'IS'
      #     is_set? arguments
      #   when 'AND'
      #     raise HungryFormException, "No arguments for AND comparison: #{arguments}" if arguments.size == 0

      #     arguments.each do |argument|
      #       return false if !resolve_dependency(argument)
      #     end

      #     true
      #   when 'OR'
      #     raise HungryFormException, "No arguments for OR comparison: #{arguments}" if arguments.size == 0

      #     arguments.each do |argument|
      #       return true if resolve_dependency(argument)
      #     end

      #     false
      #   end
      # end
    end
  end
end