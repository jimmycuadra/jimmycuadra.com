require "securerandom"

ENV["RAILS_ENV"] ||= "test"
ENV["SECRET_TOKEN"] ||= SecureRandom.hex(64)
ENV["ADMIN_EMAIL"] ||= "admin@example.com"

require "simplecov"
SimpleCov.start "rails"

require File.expand_path("../../config/environment", __FILE__)

require 'rspec/rails'
require 'capybara/rspec'
require "capybara/poltergeist"

Capybara.javascript_driver = :poltergeist

Dir[Rails.root.join("spec/support/**/*.rb")].each { |file| require file }

RSpec.configure do |config|
  config.use_transactional_fixtures = true
  config.expect_with(:rspec) { |c| c.syntax = :expect }
  config.include CapybaraHelper
end
