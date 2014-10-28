class HungryForm
  class Page < BaseGroup
    attr_accessor :title, :label

    def initialize(name, options = {}, resolver, &block)
      @label = options[:label] || name.to_s.humanize
      @title = options[:title] || @label

      super
    end
  end
end