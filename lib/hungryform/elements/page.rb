class HungryForm
  class Page < BaseGroup
    attr_accessor :title, :label

    def initialize(name, options = {}, resolver, &block)
      @label = options[:label] || name.to_s.humanize
      @title = options[:title] || @label

      super
    end

    def group(name, options = {}, &block)
      @elements << Elements::Group.new(name, options, @resolver)
      instance_eval(&block)
    end
  end
end