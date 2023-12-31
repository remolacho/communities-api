require_relative "boot"

require "rails/all"

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module SkeletonRails
  class Application < Rails::Application
    # Initialize configuration defaults for originally generated Rails version.
    config.load_defaults 7.0

    # Configuration for the application, engines, and railties goes here.
    #
    # These settings can be overridden in specific environments using the files
    # in config/environments, which are processed later.
    #
    # config.time_zone = "Central Time (US & Canada)"
    # config.eager_load_paths << Rails.root.join("extras")

    # Only loads a smaller set of middleware suitable for API only apps.
    # Middleware like session, flash, cookies can be added back manually.
    # Skip views, helpers and assets when generating a new resource.
    config.api_only = true
    config.application_name = ENV.fetch('APPLICATION_NAME', '')
    config.api_version = ENV.fetch('API_VERSION', 'version not set')

    config.i18n.load_path += Dir[Rails.root.join('config/locales/**/*.yml').to_s]
    config.i18n.available_locales = %i[en es]
    config.i18n.default_locale = :es
    config.time_zone = "America/Bogota"
  end
end
