app = Class.new(Rails::Application)

# Rais.root
app.config.root = File.dirname(__FILE__)
Rails.backtrace_cleaner.remove_silencers!
app.initialize!

# routes
app.routes.draw do
end

# helpers
Object.const_set(:ApplicationHelper, Module.new)