source "https://rubygems.org"

## Default gems

gem "rails"
gem "thin"
gem "dalli"
gem "friendly_id"
gem "will_paginate"
gem "acts-as-taggable-on"
gem "haml"
gem 'jquery-rails'
gem "formtastic"
gem "coderay"
gem "redcarpet"
gem "nokogiri"
gem "rails_autolink"

group :assets do
  gem 'sass-rails'
  gem 'coffee-rails'
  gem 'uglifier'
end

group :production do
  gem "pg"
end

group :development do
  gem "foreman"
end

group :development, :test do
  gem "sqlite3"
  gem "debugger"
end

group :test do
  gem "rspec-rails"
  gem "capybara"
  gem "poltergeist"
  gem "factory_girl_rails"
  gem "simplecov", require: false
end
