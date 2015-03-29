module HungryForm
  module Elements
    module Base
      # The Element class is used in every form element. It contains the attrs
      # and methods used by all form elements, such as name, visible, dependency etc
      class Element
        include HungryForm::Elements::Base::Hashable
        attr_accessor :name, :placeholders, :resolver, :visible, :label, :dependency, :attributes
        alias_method :visible?, :visible

        hashable :visible, :dependency, :name, :label

        def initialize(name, parent, resolver, attributes = {})
          @attributes = HungryForm.configuration.send(self.class.name.demodulize.underscore).dup
          @attributes.merge!(attributes)

          @placeholders ||= {}
          @resolver = resolver

          self.dependency ||= @attributes.delete(:dependency)

          # The element is visible if no visible parameter passed or
          # visible param equals true and the dependency is resolved positively
          self.visible = @attributes.key?(:visible) ? @attributes.delete(:visible) : true

          if dependency
            self.visible &&= resolver.resolve_dependency(dependency)
          end

          # An element's name is prefixed with all parents names up to the page
          self.name = resolver.get_value(name, self)
          self.name = "#{parent.name}_#{name}" unless parent.nil?
          
          # Label can be created from name if there is no label given
          if @attributes[:label]
            self.label = resolver.get_value(@attributes.delete(:label), self)
          else
            self.label = resolver.get_value(name, self).humanize
          end
        end

        def dependency_json
          JSON.generate(dependency) if dependency
        end
      end
    end
  end
end
