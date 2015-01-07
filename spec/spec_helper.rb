begin
  require 'rails'
rescue LoadError
end

require 'bundler/setup'
Bundler.setup

require 'hungryform'

if defined? Rails
  require 'app/app'
  require 'rspec/rails'
  require 'capybara/rails'
  require 'capybara/poltergeist'
  Capybara.javascript_driver = :poltergeist
  
  RSpec.configure do |config|
    config.infer_spec_type_from_file_location!
  end
end

Dir['./spec/support/**/*.rb'].each { |f| require f }
Dir['./spec/elements/shared_examples/**/*.rb'].each { |f| require f }
Dir['./spec/views/shared_examples/**/*.rb'].each { |f| require f }

RSpec.configure do |config|
  config.order = :random
end
