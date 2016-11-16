OmniAuth.config.logger = Rails.logger
OmniAuth.config.full_host = Rails.env.production? ? 'https://https://watermarker-staging.herokuapp.com' : 'http://127.0.0.1:3000'

Rails.application.config.middleware.use OmniAuth::Builder do
  provider :google_oauth2, ENV["GOOGLE_CLIENT_ID"], ENV["GOOGLE_CLIENT_SECRET"],
    {
      :access_type => 'offline',
      :scope => 'email, https://www.googleapis.com/auth/drive, https://www.googleapis.com/auth/drive.metadata.readonly',
      :prompt => 'consent'
    }
end

