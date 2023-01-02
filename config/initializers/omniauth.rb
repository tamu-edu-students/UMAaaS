Rails.application.config.middleware.use OmniAuth::Builder do
    config = YAML::load(File.open("#{Rails.root.to_s}/config/settings.yml"))
    OmniAuth.config.allowed_request_methods = [:post, :get]
    OmniAuth.config.silence_get_warning = true

  
  # change this
    provider :google_oauth2, '890464551227-vlrtvoqgamv76vtaqn9hm05bl304ldvu.apps.googleusercontent.com',
                            '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',
                            image_size: 150,
                            skip_jwt: true
end