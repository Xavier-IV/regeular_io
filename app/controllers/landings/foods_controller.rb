# frozen_string_literal: true

class Landings::FoodsController < ApplicationController
  def index
    @tags = [
      'Malay Cuisine', 'Chinese', 'Seafood', 'Arab',
      'Fast Food', '+20'
    ]
    business_names = Business.listed.distinct.pluck(:state)
    @states = Common::State.where(name: business_names)
    @cities = if query_params[:state].present?
                Common::State.find_by(name: query_params[:state])
                             .cities.where(
                               name: Business.where(state: query_params[:state]).distinct.pluck(:city)
                             )
              else
                []
              end

    @businesses = Business.listed
                          .most_regular(query_params[:most].present? && query_params[:most] == 'regular')
                          .most_rating(query_params[:most].present? && query_params[:most] == 'rating')
                          .with_state(query_params[:state])
                          .with_city(query_params[:city])
  end

  private

  def query_params
    params.permit(:most, :state, :city)
  end
end
