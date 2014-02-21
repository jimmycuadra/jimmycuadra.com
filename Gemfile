source "https://rubygems.org"

ruby "2.1.0"

gem "rails", "4.0.3"
gem "thin"
gem "dalli"
gem "friendly_id"
gem "will_paginate"
gem "acts-as-taggable-on"
gem "haml"
gem 'jquery-rails'
gem "formtastic", ">= 2.3.0.rc"
gem "coderay"
gem "redcarpet"
gem "nokogiri"
gem "rails_autolink"
gem 'sass-rails'
gem 'coffee-rails'
gem 'uglifier'
gem "rack-cache"

group :production do
  gem "pg"
  gem "rails_12factor"
  gem "memcachier"
end

group :development do
  gem "foreman"
end

group :development, :test do
  gem "sqlite3"
end

group :test do
  gem "rspec-rails"
  gem "capybara"
  gem "poltergeist"
  gem "factory_girl_rails"
  gem "simplecov", require: false
end
