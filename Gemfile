source "https://rubygems.org"

gem "rails"

server = -> do
  gem "thin"
end

postgres = -> do
  gem "pg"
end

sqlite = -> do
  gem "sqlite3"
end

middleware = -> do
  gem "rack-rewrite"
end

caching = -> do
  gem "dalli"
end

model = -> do
  gem "friendly_id"
  gem "will_paginate"
  gem "acts-as-taggable-on"
end

view = -> do
  gem "haml"
  gem 'jquery-rails'
  gem "formtastic"
  gem "coderay"
  gem "redcarpet"
  gem "nokogiri"
  gem "rails_autolink"
end

tasks = -> do
  gem "heroku_backup_task"
end

assets = -> do
  gem 'sass-rails'
  gem 'coffee-rails'
  gem 'uglifier'
end

pry = -> do
  gem 'pry'
  gem 'pry-rails'
  gem 'pry-nav'
  gem 'pry-coolline'
end

testing = -> do
  gem "capybara"
  gem "poltergeist"
  gem "simplecov", require: false
  gem "rspec-rails"
end

factories = -> do
  gem "factory_girl_rails"
end

workflow = -> do
  gem "foreman"
  gem "spork"
end

guard = -> do
  gem "guard"
  gem "guard-rspec"
  gem "guard-process"
  gem "guard-spork"
  gem "ruby_gntp"
  gem "rb-fsevent"
end

#####

common = -> do
  server.call
  middleware.call
  caching.call
  model.call
  view.call
end

#####

group :production do
  common.call
  postgres.call
  tasks.call
end

group :development do
  common.call
  sqlite.call
  assets.call
  pry.call
end

group :test do
  common.call
  sqlite.call
  assets.call
  pry.call
  testing.call
  factories.call
  workflow.call
  guard.call
end
