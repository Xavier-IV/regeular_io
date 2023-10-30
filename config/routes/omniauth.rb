# frozen_string_literal: true

get '/auth/twitter/callback' => 'omniauth_sessions#twitter'
get '/auth/google_oauth2/callback' => 'omniauth_sessions#google_oauth2'
