source :rubygems

# Rails
gem 'rails', '3.2.3'

# Server
gem 'thin'

# Middleware
gem 'rack-rewrite'

# Caching
gem 'dalli'

# Model
gem 'friendly_id'
gem 'will_paginate'
gem 'acts-as-taggable-on'

# View
gem 'haml'
gem 'formtastic'
gem 'coderay'
gem 'redcarpet', '1.17.2'
gem 'nokogiri'
gem 'rails_autolink'

# Rake tasks
gem 'heroku_backup_task'

# jQuery
gem 'jquery-rails'

group :assets do
  gem 'sass-rails'
  gem 'coffee-rails'
  gem 'uglifier'
end

group :production do
  gem 'pg'
end

group :development do
  gem 'pry'
  gem 'pry-nav'
  gem 'pry-coolline'
end

group :test do
end

group :development, :test do
  gem 'foreman'
  gem 'sqlite3'
  gem 'rspec-rails'
  gem 'factory_girl_rails'
  gem 'simplecov', require: false
  gem 'spork'
  gem 'guard'
  gem 'guard-rspec'
  gem 'guard-process'
  gem 'guard-spork'
  gem 'ruby_gntp'
  gem 'rb-fsevent' if RUBY_PLATFORM.include?("darwin")
end
