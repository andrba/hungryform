require 'rubygems'
require 'bundler/gem_tasks'
require 'rspec/core/rake_task'


RSpec::Core::RakeTask.new(:spec)

task :default => "spec:all"

namespace :spec do
  mappers = %w(
    rails41
    rails40
    rails32
  )

  mappers.each do |gemfile|
    desc "Run Tests against #{gemfile}"
    task gemfile do
      sh "BUNDLE_GEMFILE='gemfiles/#{gemfile}.gemfile' bundle --quiet"
      sh "BUNDLE_GEMFILE='gemfiles/#{gemfile}.gemfile' bundle exec rake -t spec"
    end
  end

  desc "Run Tests against all ORMs"
  task :all do
    mappers.each do |gemfile|
      sh "BUNDLE_GEMFILE='gemfiles/#{gemfile}.gemfile' bundle --quiet"
      sh "BUNDLE_GEMFILE='gemfiles/#{gemfile}.gemfile' bundle exec rake spec"
    end
  end
end