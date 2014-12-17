require 'json'
require 'active_support/core_ext/string/inflections'
require 'active_support/core_ext/class/attribute'
require 'hungryform/version'
require 'hungryform/form'
require 'hungryform/resolver'
require 'hungryform/validator'
require 'hungryform/elements'

module HungryForm
  HungryFormException = Class.new(StandardError)
end
