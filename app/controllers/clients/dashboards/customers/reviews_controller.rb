# frozen_string_literal: true

class Clients::Dashboards::Customers::ReviewsController < ApplicationController
  include Dashboard::Layout
  include Dashboard::Auth

  def index
    business = current_client.business
    @customer = User.find(query_params[:id])
    @reviews = @customer.reviews.where(business_id: business.id).order(created_at: :desc)
  end

  private

  def query_params
    params.permit(:id)
  end
end
