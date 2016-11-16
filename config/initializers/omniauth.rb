OmniAuth.config.logger = Rails.logger
OmniAuth.config.full_host = ENV["DOMAIN"]

Rails.application.config.middleware.use OmniAuth::Builder do
  provider :google_oauth2, ENV["GOOGLE_CLIENT_ID"], ENV["GOOGLE_CLIENT_SECRET"],
    {
      :access_type => 'offline',
      :scope => 'email, https://www.googleapis.com/auth/drive.file, https://www.googleapis.com/auth/drive.readonly',
      :prompt => 'consent'
    }
end

