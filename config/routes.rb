# frozen_string_literal: true

Rails.application.routes.draw do
  root 'landings#index'

  get '/health', to: 'health_checks#health'

  get '/states', to: 'geographies#states', defaults: { format: :json }
  get '/cities', to: 'geographies#cities', defaults: { format: :json }

  get '/auth/twitter/callback' => 'omniauth_sessions#twitter'
  get '/auth/google_oauth2/callback' => 'omniauth_sessions#google_oauth2'

  # ====> Customer
  constraints host: Rails.application.credentials.dig(:host, :review) do
    default_url_options({ host: Rails.application.credentials.dig(:host, :review) }.tap do |options|
      options[:port] = 3000 if Rails.env.development?
    end)

    devise_for :customers, controllers: {
      registrations: 'customers/registrations',
      sessions: 'customers/sessions',
      unlocks: 'customers/unlocks',
      passwords: 'customers/passwords'
    }

    # Food Reviewers Landing Page
    get '/r', to: 'landings/foods#index', as: :food_root

    resource :qr_code, only: :show
    namespace :qr_codes do
      resource :bank
      resource :review, only: %i[new create show]
    end

    namespace :customers do
      resource :dashboard
      namespace :dashboards do
        resource :account
      end
    end
  end

  # ====> Business
  constraints host: Rails.application.credentials.dig(:host, :business) do
    default_url_options({ host: Rails.application.credentials.dig(:host, :business) }.tap do |options|
      options[:port] = 3000 if Rails.env.development?
    end)

    devise_for :clients, controllers: {
      registrations: 'clients/registrations',
      confirmations: 'dashboards/confirmations',
      sessions: 'clients/sessions',
      unlocks: 'clients/unlocks',
      passwords: 'clients/passwords',
      invitations: 'clients/invitations'
    }

    # Business Landing Page
    get '/home', to: 'landings/businesses#index', as: :business_root

    resources :dashboards, only: :index
    namespace :dashboards do
      devise_scope :client do
        resources :confirmations
      end

      namespace :qrs do
        resource :bank
        resources :reviews
      end

      resources :customers
      namespace :customers do
        scope ':id' do
          resources :reviews
        end
      end

      resources :teams, only: %i[index]
      resources :rewards
      resources :qrs
      # resources :products # Feature on hold
      resources :rewards
      resources :regulars

      resource :onboarding
      resource :business, only: %i[edit update]
      resource :account
    end
  end
end
