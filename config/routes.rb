# frozen_string_literal: true

Rails.application.routes.draw do
  namespace :dashboards do
    get 'rewards/index'
    get 'rewards/show'
    get 'rewards/edit'
  end
  root 'landings#index'

  get '/health', to: 'health_checks#health'

  get '/states', to: 'geographies#states', defaults: { format: :json }
  get '/cities', to: 'geographies#cities', defaults: { format: :json }

  # ====> Authentication
  # Handle routing for authentication
  devise_for :users, controllers: {
    registrations: 'users/registrations',
    confirmations: 'users/confirmations',
    sessions: 'users/sessions',
    unlocks: 'users/unlocks',
    passwords: 'users/passwords',
    omniauth_callbacks: 'users/omniauth_callbacks'
  }

  authenticated :user do
    root 'landings#index', as: :root_authenticated
  end

  # ====> Customer
  constraints host: Rails.application.credentials.dig(:host, :review) do
    default_url_options({ host: Rails.application.credentials.dig(:host, :review) }.tap do |options|
      options[:port] = 3000 if Rails.env.development?
    end)

    # Food Reviewers Landing Page
    get '/foods', to: 'landings/foods#index', as: :food_root

    resource :qr_code, only: :show
    namespace :qr_codes do
      resource :bank
      resource :review, only: %i[new create show]
    end
  end

  # ====> Business
  constraints host: Rails.application.credentials.dig(:host, :business) do
    default_url_options({ host: Rails.application.credentials.dig(:host, :business) }.tap do |options|
      options[:port] = 3000 if Rails.env.development?
    end)

    # Business Landing Page
    get '/home', to: 'landings/businesses#index', as: :business_root

    resources :dashboards, only: :index
    namespace :dashboards do
      devise_scope :user do
        resources :confirmations
      end

      namespace :qrs do
        resource :bank
        resources :reviews
      end

      resources :qrs
      # resources :products # Feature on hold
      resources :rewards
      resources :reviews
      resources :regulars

      resource :onboarding
      resource :business, only: %i[edit update]
      resource :account
    end
  end
end
