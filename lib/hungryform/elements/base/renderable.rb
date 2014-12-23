module HungryForm
  module Elements
    module Base
      module Renderable
        def html_class
          classes = []
          classes << attributes[:class] if attributes[:class]
          classes << 'hidden' unless visible?
          classes << 'invalid' if self.respond_to?(:invalid?) && self.invalid?
          classes.join(' ') if classes.any?
        end
      end
    end
  end
end
