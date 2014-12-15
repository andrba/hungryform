class HungryForm
  # A base group object is used to handle nested elements.
  # Nested element can be a regular BaseElement or BaseActiveElement, as well as a BaseGroup element.
  # 
  # The following sample has three BaseGroup elements (page, group and nested group) that define a structure
  # of a single form page
  # 
  # page :about do
  #   group :about_yourself do
  #     html :about, value: "Tell us about yourself"
  #     group :address do
  #       text_field :street
  #       text_field :city
  #     end
  #     group :contact do
  #       text_field :phone
  #     end
  #   end
  # end
  # 
  # Every group element except for a nested group is 
  class BaseGroup < BaseElement
    attr_accessor :elements, :errors

    hashable :elements

    def initialize(name, parent, resolver, attributes = {}, &block)
      raise HungryFormException, 'No group structure block given' unless block_given?

      super
      
      @elements = []
      @errors = {}

      instance_eval(&block)
    end

    # Validates an entire group. If a group consists of nested groups
    # they will be validated recursively
    def valid?
      errors.clear
      is_valid = true

      elements.each do |el|
        if el.invalid?
          is_valid = false
          case el
          when BaseActiveElement
            errors[el.name] = el.error
          when BaseGroupObject
            errors.merge!(el.errors)
          end
        end
      end

      is_valid
    end

    def invalid?
      !valid?
    end

    def to_hash
      super.merge({ :elements => self.elements.map(&:to_hash) })
    end

    def method_missing(method_name, *args, &block)
      #Find a matching class
      klass = HungryForm.constants.find { |c| Class === HungryForm.const_get(c) && c.to_s.underscore.to_sym == method_name }
      return super if klass.nil?

      # Create a new element based on a symbol provided and push it into the group elements array
      element = HungryForm::const_get(klass).send(:new, args[0], self, @resolver, *(args[1..-1]), &block)
      elements << element

      #Resolver keeps a hash of all elements of the form
      @resolver.elements[element.name] = element

      element
    end

    def respond_to_missing?(method_name, include_private = false)
      HungryForm.constants.any? { |c| Class === HungryForm.const_get(c) && c.to_s.underscore.to_sym == method_name } || super
    end
  end
end