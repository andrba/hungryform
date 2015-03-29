module HungryForm
  class Configuration
    attr_accessor :views_prefix

    def initialize
      @views_prefix = 'hungryform'

      init_element_default_attributes
    end

    private

    def init_element_default_attributes
      @elements_default_attributes = {}

      HungryForm::Elements.all_classes.each do |klass|
        klass_name = klass.to_s.underscore.to_sym
        @elements_default_attributes[klass_name] = {}

        define_singleton_method klass_name do
          @elements_default_attributes[klass_name]
        end
      end
    end
  end
end