require_relative 'boot'

require 'rails/all'

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

if ['development', 'test'].include? ENV['RAILS_ENV']
  Dotenv::Railtie.load
end

module Reviews
  class Application < Rails::Application
    # Initialize configuration defaults for originally generated Rails version.
    config.load_defaults 6.0

    config.admin_email = ENV["ADMIN_EMAIL"]
    
    config.time_zone = "Central Time (US & Canada)"
    
    # Maximum number of experience comments to show on the portal view (all comments are shown on single experience view)
    config.max_comments_shown = "10";
    config.assets.initialize_on_precompile = false
    
    # Settings in config/environments/* take precedence over those specified here.
    # Application configuration can go into files in config/initializers
    # -- all .rb files in that directory are automatically loaded after loading
    # the framework and any gems in your application.
  end
end
