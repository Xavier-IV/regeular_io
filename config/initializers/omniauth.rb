# frozen_string_literal: true

Rails.application.config.middleware.use OmniAuth::Builder do
  provider :google_oauth2, Rails.application.credentials.dig(:google, :oauth, :client_id),
           Rails.application.credentials.dig(:google, :oauth, :client_secret), {
             scope: 'email,profile',
             prompt: 'select_account'
           }

  provider :twitter, Rails.application.credentials.dig(:twitter, :oauth, :client_id),
           Rails.application.credentials.dig(:twitter, :oauth, :client_secret)

  # Add other providers as needed
end
