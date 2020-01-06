Rails.application.config.middleware.use OmniAuth::Builder do
    config = YAML::load(File.open("#{Rails.root.to_s}/config/settings.yml"))
  
  # change this
    provider :google_oauth2, '971181149334-d9avbf8shp6ku8vgpvlkbntcohonhh5s.apps.googleusercontent.com',
                            '5UgDl6FSacW1DYobM11yPhJt',
                            image_size: 150,
                            skip_jwt: true
end