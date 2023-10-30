# frozen_string_literal: true

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

      scope ':business_id' do
        resources :reviews
      end
    end
  end
end
