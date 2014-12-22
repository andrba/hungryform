require 'action_controller/railtie'
require 'action_view/railtie'

app = Class.new(Rails::Application)
app.config.secret_token = '6fd8fedc4c9d1c834f42b59f6e2cb39ce8c2dc68aafde87ddc5fa64803864b03dc59c61d99f406f76f597cdbc3b923a6c11a9d7580d8e0005837df9fdff262ef'
app.config.eager_load = false
app.config.active_support.deprecation = :log

# Rais.root
app.config.root = File.dirname(__FILE__)
Rails.backtrace_cleaner.remove_silencers!
app.initialize!

# routes
app.routes.draw do
  get 'hungryform/:page' => 'hungryform#show'
  post 'hungryform/:page' => 'hungryform#update'
end

# helpers
Object.const_set(:ApplicationHelper, Module.new)
ApplicationHelper.include Rails.application.routes.url_helpers
