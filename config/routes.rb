# frozen_string_literal: true

Rails.application.routes.draw do
  match "/404", to: "errors#not_found", via: :all
  match "/500", to: "errors#internal_server_error", via: :all

  namespace :customers do
    namespace :dashboards do
      get 'rewards/show'
    end
  end
  root 'landings#index'

  get '/health', to: 'health_checks#health'

  get '/states', to: 'geographies#states', defaults: { format: :json }
  get '/cities', to: 'geographies#cities', defaults: { format: :json }

  draw(:omniauth)
  draw(:customer)
  draw(:business)
end
