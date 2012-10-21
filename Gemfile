source "https://rubygems.org"

# Internal: A Hash of Procs containing subgroup code.
@subgroups = {}

# Public: Defines a subgroup for later inclusion in an environment-based group.
#
#   name  - A Symbol name for the group.
#   block - A Proc to be called when the subgroup is included.
#
# Returns nothing.
def subgroup(name, &block)
  @subgroups[name] = block
end

# Public: Includes gems in a group by evaluating stored Procs within an environment-based group.
#
#   group_name      - The Symbol name of the group to compose.
#   subgroup_names  - One or more Symbol names of the subgroup(s) to include.
#
# Returns nothing.
def compose_group(group_name, *subgroup_names)
  group(group_name) do
    subgroup_names.each { |name| @subgroups[name].call }
  end
end


## Default gems

gem "rails"

# Server
gem "thin"

#Middleware
gem "rack-rewrite"

# Caching
gem "dalli"

# Model
gem "friendly_id"
gem "will_paginate"
gem "acts-as-taggable-on"

# View
gem "haml"
gem 'jquery-rails'
gem "formtastic"
gem "coderay"
gem "redcarpet"
gem "nokogiri"
gem "rails_autolink"

# Assets
gem 'sass-rails'
gem 'coffee-rails'
gem 'uglifier'


## Subgroups

subgroup :postgres do
  gem "pg"
end

subgroup :sqlite do
  gem "sqlite3"
end

subgroup :testing do
  gem "capybara"
  gem "poltergeist"
  gem "simplecov", require: false
  gem "rspec-rails"
end

subgroup :factories do
  gem "factory_girl_rails"
end

subgroup :workflow do
  gem "foreman"
end


## Groups

compose_group :production,
              :postgres

compose_group :development,
              :sqlite

compose_group :test,
              :sqlite, :testing, :factories, :workflow
