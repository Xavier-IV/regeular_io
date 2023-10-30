# frozen_string_literal: true

Rails.application.routes.draw do
  root 'landings#index'

  get '/health', to: 'health_checks#health'

  get '/states', to: 'geographies#states', defaults: { format: :json }
  get '/cities', to: 'geographies#cities', defaults: { format: :json }

  draw(:omniauth)
  draw(:customer)
  draw(:business)
end
