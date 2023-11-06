# frozen_string_literal: true

class GeographiesController < ApplicationController
  def states
    country = Common::Country.find_by(name: query_params[:country])
    states = country.states.order(name: :asc) if country
    states = [] unless country&.states

    render json: { states: }
  end

  def cities
    state = Common::State.find_by(name: query_params[:state])
    cities = state.cities.order(name: :asc) if state
    cities = [] unless state&.cities

    render json: { cities: }
  end

  private

  def query_params
    params.permit(:state, :country)
  end
end
