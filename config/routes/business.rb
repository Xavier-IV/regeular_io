# frozen_string_literal: true

# ====> Business
constraints host: Rails.application.credentials.dig(:host, :business) do
  default_url_options({ host: Rails.application.credentials.dig(:host, :business) }.tap do |options|
    options[:port] = 3000 if Rails.env.development?
    options[:protocol] = 'https' if Rails.env.staging? || Rails.env.production?
  end)

  # Business Landing Page
  root 'landings/businesses#index', as: :business_root
  get 'pricing', to: 'landings/businesses#pricing'

  devise_for :clients, controllers: {
    registrations: 'clients/registrations',
    confirmations: 'clients/confirmations',
    sessions: 'clients/sessions',
    unlocks: 'clients/unlocks',
    passwords: 'clients/passwords',
    invitations: 'clients/invitations'
  }

  namespace :clients do
    resources :dashboards, only: :index
    namespace :dashboards do
      resource :confirmation

      resource :tool_marketing
      namespace :tool_marketings do
        resources :copywritings
        resources :viral_contents
        resources :daily_posts
        resources :engagements
      end

      resource :tool_moodboard
      namespace :tool_moodboards do
        resources :banners
        resources :interior_designs
      end

      namespace :qrs do
        resource :bank
        resources :reviews
      end

      namespace :qr_guides do
        resource :review
        resource :bank
      end

      resources :customers
      namespace :customers do
        scope ':id' do
          resources :reviews
        end
      end

      resources :teams, only: %i[index]
      resources :qrs
      resource :setting

      resource :reward do
        scope module: 'rewards' do
          resource :discount
          resource :birthday
          resource :consume
        end
      end

      namespace :businesses do
        resource :approval
      end

      resource :onboarding
      resource :progress

      resource :business, only: %i[edit update]
      resource :account
    end
  end
end
