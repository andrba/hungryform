class HungryForm
  class Html < BaseElement
    def initialize(name, body, options = {}, resolver, &block)
      super
      self.body = body
    end
  end
end