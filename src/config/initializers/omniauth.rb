Rails.application.config.middleware.use OmniAuth::Builder do
  provider :google_oauth2, Rails.application.credentials.shared[:google][:key], Rails.application.credentials.shared[:google][:secret]
end