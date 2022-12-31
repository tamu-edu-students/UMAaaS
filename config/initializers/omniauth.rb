Rails.application.config.middleware.use OmniAuth::Builder do
    config = YAML::load(File.open("#{Rails.root.to_s}/config/settings.yml"))
    OmniAuth.config.allowed_request_methods = [:post, :get]
    OmniAuth.config.silence_get_warning = true


  
  # change this
    provider :google_oauth2, '325404468347-72uokrj376lr1ku5ddm29k1l5a90e85k.apps.googleusercontent.com',
                            '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',
                            image_size: 150,
                            skip_jwt: true
end