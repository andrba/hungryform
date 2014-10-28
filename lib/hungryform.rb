require 'active_support'
require 'active_support/core_ext/string/inflections'
require "hungryform/version"
require "hungryform/resolver"
require "hungryform/elements"

class HungryForm
  HungryFormException = Class.new(StandardError)

  attr_reader :current_page, :pages

  def initialize(options = {}, &block)
    raise HungryFormException, 'No structure block given' unless block_given?
    @resolver = Resolver.new(options.slice(:params))
    @pages = []
    instance_eval(&block)
  end

  def page(name, options = {}, &block)
    page = Page.new(name, options, @resolver, &block)
    pages << page if page.visible?
  end
end
