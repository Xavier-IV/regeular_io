# frozen_string_literal: true

# ====> Customer
constraints host: Rails.application.credentials.dig(:host, :review) do
  default_url_options({ host: Rails.application.credentials.dig(:host, :review) }.tap do |options|
    options[:port] = 3000 if Rails.env.development?
    options[:protocol] = 'https' if Rails.env.staging? || Rails.env.production?
  end)

  # Customers Landing Page
  root 'landings/customers#index', as: :customer_root

  devise_for :customers, controllers: {
    registrations: 'customers/registrations',
    sessions: 'customers/sessions',
    unlocks: 'customers/unlocks',
    passwords: 'customers/passwords'
  }, after_sign_up: '/'

  get '/how_it_works', to: 'landings/customers#how_it_works'
  post '/how_it_works', to: 'landings/customers#how_it_works_progress'

  namespace :landings, path: '' do
    namespace :customers, path: '' do
      resources :services
    end
  end

  resource :qr_code, only: :show
  namespace :qr_codes do
    resource :bank
    resource :check_in
    resource :review, only: %i[new create show]
  end

  namespace :customers do
    resource :pwa_subscription
    resource :dashboard
    namespace :dashboards do
      resource :account

      scope ':business_id' do
        resource :reward
        resources :reviews
      end
    end
  end
end
