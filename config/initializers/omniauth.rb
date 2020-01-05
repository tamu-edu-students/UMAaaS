Rails.application.config.middleware.use OmniAuth::Builder do
    config = YAML::load(File.open("#{Rails.root.to_s}/config/settings.yml"))
  
  # change this
    provider :google_oauth2, '826565649927-pvr26un99dduiv0271mm0v77b8ija8ra.apps.googleusercontent.com',
                            '9MqOoItGC1eSs61obEE4wRf6',
                            image_size: 150,
                            skip_jwt: true
end