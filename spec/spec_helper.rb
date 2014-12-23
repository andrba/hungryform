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

  RSpec.configure do |config|
    config.infer_spec_type_from_file_location!
  end
end

Dir["./spec/support/**/*.rb"].sort.each { |f| require f }

RSpec.configure do |config|
  config.order = :random
end
