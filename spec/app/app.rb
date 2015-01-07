# All in one Rails App

require 'action_controller/railtie'
require 'action_view/railtie'
require 'sprockets/railtie'

app = Class.new(Rails::Application)
app.config.secret_token = '6fd8fedc4c9d1c834f42b59f6e2cb39ce8c2dc68aafde87ddc5fa64803864b03dc59c61d99f406f76f597cdbc3b923a6c11a9d7580d8e0005837df9fdff262ef'
app.config.eager_load = false
app.config.active_support.deprecation = :log
app.config.assets.enabled = true

# Rais.root
app.config.root = File.dirname(__FILE__)
Rails.backtrace_cleaner.remove_silencers!
app.initialize!

# routes
app.routes.draw do
  get 'hungryform' => 'hungry_form#show'
  get 'hungryform/submitted' => 'hungry_form#submitted'
  get 'hungryform/:page' => 'hungry_form#show'
  post 'hungryform/:page' => 'hungry_form#update'
end

# controllers
class ApplicationController < ActionController::Base; end
class HungryFormController < ApplicationController
  before_filter :set_form

  def show
    render :inline => render_form
  end

  def update
    case params[:form_action]
    when /next/
      if @form.current_page.valid?
        redirect_to hungryform_path(page: @form.next_page) 
      else
        render :inline => render_form
      end
    when /prev/
      redirect_to hungryform_path(page: @form.prev_page)
    when /submit/
      if @form.valid?
        redirect_to hungryform_submitted_path
      else
        redirect_to hungryform_path(page: @form.pages.find(&:invalid?))
      end
    end
  end

  def submitted
    render :inline => "The form has been submitted successfully"
  end

  private

  def set_form
    @form = form(params)
  end

  def render_form
    <<-ERB
<html>
<head>
  <%= javascript_include_tag 'jquery-2.1.3.min', 'hungryform' %>
  <script type='text/javascript'>
    $(document).ready(function() {
      $('form').hungryForm();
    });
  </script>
</head>
<body>
  <%= hungry_form_for(@form) %>
</end>
ERB
  end

  def form(params)
    # See integration tests for a form definition
  end

end

# helpers
Object.const_set(:ApplicationHelper, Module.new)
ApplicationHelper.include Rails.application.routes.url_helpers
