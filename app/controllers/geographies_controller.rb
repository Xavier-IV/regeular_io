# frozen_string_literal: true

class GeographiesController < ApplicationController
  def states
    states = Common::Country.find_by(name: query_params[:country]).states.order(name: :asc)

    render json: { states: }
  end

  def cities
    state = Common::State.find_by(name: query_params[:state])
    cities = state.cities.order(name: :asc)

    render json: { cities: }
  end

  private

  def query_params
    params.permit(:state, :country)
  end
end
