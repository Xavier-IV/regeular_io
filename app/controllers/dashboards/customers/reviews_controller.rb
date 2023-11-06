# frozen_string_literal: true

class Dashboards::Customers::ReviewsController < ApplicationController
  include DashboardLayout

  def index
    @customer = User.find(query_params[:id])
    @reviews = @customer.reviews.order(created_at: :desc)
  end

  private

  def query_params
    params.permit(:id)
  end
end
