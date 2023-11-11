# frozen_string_literal: true

# ====> Business
constraints host: Rails.application.credentials.dig(:host, :admin) do
  default_url_options({ host: Rails.application.credentials.dig(:host, :admin) }.tap do |options|
    options[:port] = 3000 if Rails.env.development?
    options[:protocol] = 'https' if Rails.env.staging? || Rails.env.production?
  end)

  devise_for :admins, controllers: {
    confirmations: 'admins/confirmations',
    sessions: 'admins/sessions',
    unlocks: 'admins/unlocks',
    passwords: 'admins/passwords',
    invitations: 'admins/invitations'
  }

  resource :admins
  namespace :admins do
    resource :dashboard
    namespace :dashboards do
      post '/approvals/:business_id/approve', to: 'approvals#approve', as: :approval_approve
      post '/approvals/:business_id/reject', to: 'approvals#reject', as: :approval_reject

      resources :copywritings
    end
  end
end
