class Landings::Customers::ServicesController < ApplicationController
  def index
    @tags = [
      'Malay Cuisine', 'Chinese', 'Seafood', 'Arab',
      'Fast Food', '+20'
    ]
    business_names = Business.state_approved.distinct.pluck(:state)
    @states = Common::State.where(name: business_names)
    @cities = if query_params[:state].present?
                Common::State.find_by(name: query_params[:state])
                             .cities.where(
                  name: Business.where(state: query_params[:state]).distinct.pluck(:city)
                )
              else
                []
              end

    @businesses = Business.state_approved
                          .most_regular(query_params[:most].present? && query_params[:most] == 'regular')
                          .most_rating(query_params[:most].present? && query_params[:most] == 'rating')
                          .with_state(query_params[:state])
                          .with_city(query_params[:city])
  end

  def show
  end

  private
  def query_params
    params.permit(:most, :state, :city, :experience, :level)
  end
end
