class Dashboards::Customers::ReviewsController < ApplicationController
  include DashboardLayout

  def index
    @customer = User.find(params[:id])
    @reviews = @customer.reviews.order(created_at: :desc)
  end
end
