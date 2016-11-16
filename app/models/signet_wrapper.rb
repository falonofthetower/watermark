module SignetWrapper
  class Client
    attr_reader :response, :error_message
    attr_accessor :client

    def initialize(options={})
      @response = options[:response]
      @error_message = options[:error_message]
    end

    def self.authorize(token)
      client.refresh_token = token
      client.grant_type = "refresh_token"
      client.fetch_access_token!

      new(response: client)
    rescue Signet::AuthorizationError => e
      new(error_message: e.message)
    end

    def self.client
      @client ||= fresh_client
    end

    def self.client_options
      {
        client_id: ENV["CLIENT_ID"],
        temporary_credential_uri: 'https://www.google.com/accounts/OAuthGetRequestToken',
        # authorization_uri: 'https://www.google.com/accounts/OAuthAuthorizeToken',
        # token_credential_uri: 'https://www.google.com/accounts/OAuthGetAccessToken',
        client_credential_key: 'anonymous',
        client_credential_secret: 'anonymous',
        authorization_uri: "https://accounts.google.com/o/oauth2/auth",
        token_credential_uri: "https://accounts.google.com/o/oauth2/token",
        auth_provider_x509_cert_url: "https://www.googleapis.com/oauth2/v1/certs",
        client_secret: ENV["GOOGLE_CLIENT_SECRET"],
        redirect_uri: ENV["REDIRECT_URI"],
        javascript_origins: ENV["JAVASCRIPT_ORIGINS"]
      }
    end

    def self.fresh_client
      Signet::OAuth2::Client.new(client_options)
    end

    def successful?
      response.present?
    end
  end
end
