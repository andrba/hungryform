module HungryForm
  class Configuration
    attr_accessor :views_prefix

    def initialize
      @views_prefix = 'hungryform'
    end
  end
end