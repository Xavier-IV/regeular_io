# frozen_string_literal: true

class Landings::CustomersController < ApplicationController
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

  def how_it_works
    @rating = Review.new

    experience = query_params[:experience].to_i || 0
    level = query_params[:level].to_i || 0

    @customer_progress = Customer::Progress.new(experience:, level:)
  end

  def how_it_works_progress
    @rating = Review.new
    @customer_progress = Customer::Progress.new

    experience = query_params[:experience].to_i
    level = query_params[:level].to_i || 0

    experience += 1

    level += 1 if experience == 5
    experience = 0 if experience == 5

    redirect_to how_it_works_path(experience:, level:)
  end

  private

  def game_params
    params.require(:review).permit(:rating, :experience, :level, :description)
  end

  def query_params
    params.permit(:most, :state, :city, :experience, :level)
  end
end
