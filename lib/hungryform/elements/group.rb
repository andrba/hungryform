class HungryForm
  class Group < BaseGroup
    def initialize(name, parent, resolver, options = {}, &block)
      super
      instance_eval(&block)
    end
  end
end