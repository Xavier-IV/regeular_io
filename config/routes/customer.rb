# frozen_string_literal: true

# ====> Customer
constraints host: Rails.application.credentials.dig(:host, :review) do
  default_url_options({ host: Rails.application.credentials.dig(:host, :review) }.tap do |options|
    options[:port] = 3000 if Rails.env.development?
    options[:protocol] = 'https' if Rails.env.staging? || Rails.env.production?
  end)

  devise_for :customers, controllers: {
    registrations: 'customers/registrations',
    sessions: 'customers/sessions',
    unlocks: 'customers/unlocks',
    passwords: 'customers/passwords'
  }

  # Customers Landing Page
  get '/listings', to: 'landings/customers#index', as: :customer_root
  get '/how_it_works', to: 'landings/customers#how_it_works'
  post '/how_it_works', to: 'landings/customers#how_it_works_progress'

  resource :qr_code, only: :show
  namespace :qr_codes do
    resource :bank
    resource :review, only: %i[new create show]
  end

  namespace :customers do
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
