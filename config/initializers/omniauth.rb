# frozen_string_literal: true

Rails.application.config.middleware.use OmniAuth::Builder do
  config = YAML.load(File.open("#{Rails.root}/config/settings.yml"))
  OmniAuth.config.allowed_request_methods = %i[post get]
  OmniAuth.config.silence_get_warning = true

  # change this
  provider :google_oauth2, ENV['GOOGLE_CLIENT_ID'],
           ENV['GOOGLE_CLIENT_SECRET'],
           image_size: 150,
           skip_jwt: true
end
