require 'bundler/setup'
Bundler.setup

require 'hungryform'

Dir["./spec/support/**/*.rb"].sort.each { |f| require f }

RSpec.configure do |config|
  config.order = :random
end
