# frozen_string_literal: true

class Customers::Dashboards::ReviewsController < ApplicationController
  include Pundit::Authorization

  before_action :authenticate_customer!
  layout 'customer/dashboard'

  def index
    @reviews = current_customer.reviews.where(business_id: query_params[:business_id])
  end

  private

  def query_params
    params.permit(:business_id)
  end
end
