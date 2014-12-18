require "rails"

require 'bundler/setup'
Bundler.setup

require 'hungryform'
require 'app/app'

Dir["./spec/support/**/*.rb"].sort.each { |f| require f }

RSpec.configure do |config|
  config.order = :random
end
