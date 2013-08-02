require File.expand_path('../boot', __FILE__)

require "active_record/railtie"
require "action_controller/railtie"
require "action_mailer/railtie"
require "sprockets/railtie"
Bundler.require(:default, Rails.env)

module JimmyCuadra
  class Application < Rails::Application
    config.cache_store = :dalli_store
    config.autoload_paths += %W(#{config.root}/lib)
    config.time_zone = 'Pacific Time (US & Canada)'
    config.filter_parameters += [:password]
  end
end
