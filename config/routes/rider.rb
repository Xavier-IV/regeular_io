# frozen_string_literal: true

# ====> Business
constraints host: Rails.application.credentials.dig(:host, :rider) do
  default_url_options({ host: Rails.application.credentials.dig(:host, :rider) }.tap do |options|
    options[:port] = 3000 if Rails.env.development?
    options[:protocol] = 'https' if Rails.env.staging? || Rails.env.production?
  end)

  devise_for :riders, controllers: {
    registrations: 'riders/registrations',
    confirmations: 'riders/confirmations',
    sessions: 'riders/sessions',
    unlocks: 'riders/unlocks',
    passwords: 'riders/passwords',
    invitations: 'riders/invitations'
  }

  root 'landings/riders#index', as: :rider_root

  get 'brand/:slug', to: 'landings/riders/brands#show', as: :rider_brand

  namespace :riders do
    namespace :brands do
      scope ':brand_id' do
        resource :benefit
        resource :upvote
        resource :downvote
      end
    end
  end
end
