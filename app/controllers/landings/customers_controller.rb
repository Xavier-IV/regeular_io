# frozen_string_literal: true

class Landings::CustomersController < ApplicationController
  def index
    redirect_to customers_dashboard_path
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

    experience = game_params[:experience].to_i
    level = game_params[:level].to_i || 0

    experience += 1

    level += 1 if experience == 5 && level < 4
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
