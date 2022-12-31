require_relative 'boot'

require 'rails/all'

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module Reviews
  class Application < Rails::Application
    # Initialize configuration defaults for originally generated Rails version.
    config.load_defaults 6.0

<<<<<<< HEAD
    config.admin_email = "abhishekmore@tamu.edu"
=======
    config.admin_email = "abose0267@tamu.edu"
>>>>>>> df5a6a3784f4b2873e08333870a058bb10ee23ed
    
    config.time_zone = "Central Time (US & Canada)"
    
    # Maximum number of experience comments to show on the portal view (all comments are shown on single experience view)
    config.max_comments_shown = "10";
    config.assets.initialize_on_precompile = false
    
    
    # Place holders for Yelp Fusion's API key. Grab it
    # from https://www.yelp.com/developers/v3/manage_app
    config.YELP_API_KEY = "nAdNfTSPlY4wsOCafXhDIBdhK4zTbJ4F3LLsTpPsyeI85der6bOUWATcVPjlTvsKRFKypjk2Yk4HLEYqlCcTqcby1ShlBWxXzD3q_z32fvHTO8Wk-XaBUxeUsmYRXnYx"

    # Constants, do not change these
    config.YELP_API_HOST = "https://api.yelp.com"
    config.YELP_SEARCH_PATH = "/v3/businesses/search"
        
    # Settings in config/environments/* take precedence over those specified here.
    # Application configuration can go into files in config/initializers
    # -- all .rb files in that directory are automatically loaded after loading
    # the framework and any gems in your application.
  end
end
