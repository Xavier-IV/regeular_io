# frozen_string_literal: true

Rails.application.routes.draw do
  match '*path', to: 'notices#construction', via: :all if Rails.env.production?
  root 'notices#construction' if Rails.env.production?

  unless Rails.env.production?
    draw(:omniauth)
    draw(:admin)
    draw(:customer)
    draw(:business)

    match '/404', to: 'errors#not_found', via: :all
    match '/500', to: 'errors#internal_server_error', via: :all

    get '/health', to: 'health_checks#health'

    get '/states', to: 'geographies#states', defaults: { format: :json }
    get '/cities', to: 'geographies#cities', defaults: { format: :json }

    get '/terms_and_conditions', to: 'landings/legals#terms_and_conditions'
    get '/cookie_policy', to: 'landings/legals#cookie_policy'
    get '/privacy_policy', to: 'landings/legals#privacy_policy'
    get '/acceptable_use_policy', to: 'landings/legals#acceptable_use_policy'
    get '/disclaimer', to: 'landings/legals#disclaimer'

    get '/construction', to: 'notices#construction'

    post '/clients/webhook', to: 'clients/webhooks#stripe'

    post 'pwa_subscriptions', to: 'pwa_subscriptions#create'
  end
end
