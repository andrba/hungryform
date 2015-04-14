module HungryForm
  module Elements
    class CheckboxField < Base::ActiveElement
      def set_value
        super

        if resolver.params.key?(name)
          self.attributes[:checked] = 'checked'
        else
          self.attributes[:checked] = ''
        end
      end
    end
  end
end
