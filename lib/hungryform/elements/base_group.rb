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

    def initialize(name, options = {}, resolver, &block)
      raise HungryFormException, 'No group structure block given' unless block_given?

      super
      self.elements = []
      self.errors = {}
      instance_eval(&block)
    end

    def group(name, options = {}, &block)
      elements << HungryForm::Group.new("#{self.name}_#{name}", options, @resolver, &block)
    end

    def valid?
      errors.clear
      is_valid = true
      elements.each do |el|
        case el
        when BaseActiveElement
          if el.invalid?
            is_valid = false
            errors[el.name] = el.error
          end
        when BaseGroupObject
          if el.invalid?
            is_valid = false
            errors.merge!(el.errors)
          end
        end
      end
      is_valid
    end

    def invalid?
      !valid?
    end

    def method_missing(name, *args, &block)
      #Find a matching class
      klass = HungryForm.constants.find {|c| Class === HungryForm.const_get(c) && c.to_s.underscore.to_sym == name}
      return super if klass.nil?

      element = HungryForm::const_get(klass).send(:new, *(["#{self.name}_#{args[0]}", args[1..-1], @resolver].flatten), &block)
      elements << element
      #Resolver keeps a hash of all elements of the form
      @resolver.elements[element.name] = element
      element
    end
  end
end