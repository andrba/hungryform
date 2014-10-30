class HungryForm
  class Group < BaseGroup
    def initialize(name, parent_name, options = {}, resolver, &block)
      super
      instance_eval(&block)
    end
  end
end