module HungryForm
  module Elements
    module Base
      module Renderable
        def html_class
          classes = []
          classes << attributes[:class] if attributes[:class]
          classes << 'hidden' unless visible?
          classes << 'invalid' if self.is_a?(Base::ActiveElement) && self.invalid?
          classes.join(' ') if classes.any?
        end
      end
    end
  end
end
