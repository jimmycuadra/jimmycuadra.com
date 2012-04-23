require 'rubygems'
require 'spork'

unless ENV["DRB"]
  require 'simplecov'
  SimpleCov.start "rails"
end

Spork.prefork do
  ENV["RAILS_ENV"] ||= 'test'

  require File.expand_path("../../config/environment", __FILE__)

  require 'rspec/rails'
  require 'capybara/rspec'
  require 'capybara/poltergeist'
  Capybara.javascript_driver = :poltergeist

  Dir[Rails.root.join("spec/support/**/*.rb")].each {|f| require f}

  RSpec.configure do |config|
    config.mock_with :rspec
    config.use_transactional_fixtures = true
  end
end

Spork.each_run do
  require 'simplecov'

  SimpleCov.start "rails"

  FactoryGirl.reload
end
