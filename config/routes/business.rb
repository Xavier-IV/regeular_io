# frozen_string_literal: true

# ====> Business
constraints host: Rails.application.credentials.dig(:host, :business) do
  default_url_options({ host: Rails.application.credentials.dig(:host, :business) }.tap do |options|
    options[:port] = 3000 if Rails.env.development?
    options[:protocol] = 'https' if Rails.env.staging? || Rails.env.production?
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
    resources :qrs
    # resources :products # Feature on hold

    resource :reward do
      scope module: 'rewards' do
        resource :discount
        resource :consume
      end
    end

    namespace :businesses do
      resource :approval
    end

    resources :regulars

    resource :onboarding
    resource :progress

    resource :business, only: %i[edit update]
    resource :account
  end
end
