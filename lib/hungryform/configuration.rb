module HungryForm
  class Configuration
    def initialize
      init_element_default_attributes
    end

    private

    def init_element_default_attributes
      @elements_default_attributes = {}

      HungryForm::Elements.all_classes.each do |klass|
        klass_name = klass.to_s.underscore.to_sym
        @elements_default_attributes[klass_name] = {}

        # Assign a default attribute to an element
        define_singleton_method klass_name do |attributes = {}|
          if attributes.any?
            @elements_default_attributes[klass_name].merge!(attributes)
          end

          @elements_default_attributes[klass_name]
        end
      end
    end
  end
end