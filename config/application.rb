require_relative 'boot'
require 'rails/all'

Bundler.require(*Rails.groups)

module SampleApp
    class Application < Rails::Application
       config.load_defaults 5.2
       config.i18n.load_path += Dir[Rails.root.join('config', 'locales', '**', '*.{rb,yml}')]
       config.i18n.default_locale = :en
       config.i18n.available_locales = [:en, :vi]
    end
end

