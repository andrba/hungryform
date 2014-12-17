require 'json'
require 'active_support/core_ext/string/inflections'
require 'active_support/core_ext/class/attribute'
require 'hungryform/version'
require 'hungryform/resolver'
require 'hungryform/validator'
require 'hungryform/elements'

# HungryForm is an object that manages form creation and validation.
# A sample object could look like this:
#
# form = HungryForm::Form.new :params => params do
#   page :about_yourself do
#     text_field :first_name, :required => true
#     text_field :last_name, :required => true
#     checkbox :dog, label: "Do you have a dog?"
#   end
#   page :about_your_dog, visible: '{"SET": "about_yourself_dog"}' do
#     text_field :name, :required
#     text_area :what_can_it_do, label: "What can it do?"
#   end
# end
#
# A form must contain only pages.
# Whenever a specific form error occurres inside the form it raises a HungryFormException
#
# When a new instance of a HungryForm is created, it uses attributes[:params] to
# build a structure of itself. The pages with dependencies, that resolve during this
# process will be included in the form.pages array. Pages without dependencies will be allways resolved. 
# The rest of the pages will be ignored
module HungryForm
  class Form
    attr_reader :pages

    def initialize(attributes = {}, &block)
      fail HungryFormException, 'No form structure block given' unless block_given?

      @resolver = Resolver.new(attributes.slice(:params))
      @pages = []

      instance_eval(&block)
    end

    # Create a form page
    def page(name, attributes = {}, &block)
      page = Elements::Page.new(name, nil, @resolver, attributes, &block)
      pages << page if page.visible?
    end

    # Entire form validation. Loops through the form pages and validates each page
    def valid?
      is_valid = true

      pages.each do |page|
        # Loop through pages to get all errors
        is_valid = false if page.invalid?
      end

      is_valid
    end

    def invalid?
      !valid?
    end

    # Get all the elements that the form consists of
    def elements
      @resolver.elements
    end

    def to_hash
      { pages: pages.map(&:to_hash) }
    end

    def to_json
      JSON.generate(to_hash)
    end
  end
end
