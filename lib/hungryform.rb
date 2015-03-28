module HungryForm
  class << self
    attr_writer :configuration

    def configuration
      @configuration ||= Configuration.new
    end

    def configure
      yield(configuration)
    end

    def reset_config
      @configuration = Configuration.new
    end
  end
end

begin
  require 'rails'
rescue LoadError
  #do nothing
end

require 'json'
require 'active_support/core_ext/string/inflections'
require 'active_support/core_ext/class/attribute'
require 'hungryform/version'
require 'hungryform/form'
require 'hungryform/exceptions'
require 'hungryform/resolver'
require 'hungryform/configuration'
require 'hungryform/validator'
require 'hungryform/elements'

if defined? Rails
  require 'hungryform/railtie'
  require 'hungryform/engine'
  require 'hungryform/elements/base/renderable'
  require 'hungryform/helpers/action_view'
end