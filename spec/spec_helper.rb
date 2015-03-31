require 'bundler/setup'
Bundler.setup

require 'hungryform'

Dir['./spec/support/**/*.rb'].each { |f| require f }
Dir['./spec/elements/shared_examples/**/*.rb'].each { |f| require f }
Dir['./spec/views/shared_examples/**/*.rb'].each { |f| require f }

RSpec.configure do |config|
  config.order = :random
end
