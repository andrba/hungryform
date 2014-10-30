require 'active_support'
require 'active_support/core_ext/string/inflections'
require 'hashie'
require "hungryform/version"
require "hungryform/resolver"
require "hungryform/validator"
require "hungryform/elements"

# HungryForm is an object that manages form creation and validation.
# A sample object could look like this:
# 
# form = HungryForm.new :params => params do
#   page :about_yourself do
#     text_field :first_name, :required
#     text_field :last_name, :required
#     checkbox :dog, label: "Do you have a dog?"
#   end
#   page :about_your_dog, visible: '{"IS": "about_yourself_dog"}' do
#     text_field :name, :required
#     text_area :what_can_it_do, label: "What can it do?"
#   end
# end
# 
# A form must contain only pages.
# Whenever an error occurres inside the form it raises a HungryFormException
# 
# When a new instance of a HungryForm is created, it uses options[:params] to
# build a structure of itself. The pages with dependencies, that resolve during this
# process will be included in the form.pages array. The rest of the pages will be ignored
class HungryForm
  HungryFormException = Class.new(StandardError)

  attr_reader :current_page, :pages

  def initialize(options = {}, &block)
    raise HungryFormException, 'No form structure block given' unless block_given?
    @resolver = Resolver.new(options.slice(:params))
    @pages = []
    instance_eval(&block)
  end

  def page(name, options = {}, &block)
    page = Page.new(name, "", options, @resolver, &block)
    pages << page if page.visible?
  end

  # Entire form validation. Loops through the form pages and validates each page
  def valid?
    is_valid = true
    pages.each do |page|
      #Loop through pages to get all errors
      is_valid = false if page.invalid?
    end

    is_valid
  end

  def invalid?
    !valid?
  end
end
