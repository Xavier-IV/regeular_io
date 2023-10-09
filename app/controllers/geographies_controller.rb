# frozen_string_literal: true

class GeographiesController < ApplicationController
  before_action :authenticate_user!

  def states
    states = Common::Country.find_by(name: params[:country]).states.order(name: :asc)

    render json: { states: }
  end

  def cities
    state = Common::State.find_by(name: params[:state])
    cities = state.cities.order(name: :asc)

    render json: { cities: }
  end
end
