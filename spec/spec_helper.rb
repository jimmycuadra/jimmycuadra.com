require 'rubygems'
require 'spork'

simplecov = -> do
  require "simplecov"
  SimpleCov.start "rails"
end

Spork.prefork do
  ENV["RAILS_ENV"] ||= 'test'

  simplecov.call unless ENV["DRB"]

  require File.expand_path("../../config/environment", __FILE__)

  require 'rspec/rails'
  require 'capybara/rspec'
  Capybara.javascript_driver = :webkit

  Dir[Rails.root.join("spec/support/**/*.rb")].each {|f| require f}

  RSpec.configure do |config|
    config.mock_with :rspec
    config.use_transactional_fixtures = true

    config.include CapybaraHelper
  end
end

Spork.each_run do
  simplecov.call if ENV["DRB"]

  FactoryGirl.reload
end
