# frozen_string_literal: true

class Customers::Dashboards::RewardsController < ApplicationController
  include Pundit::Authorization

  before_action :authenticate_customer!
  layout 'customer/dashboard'

  def show
    @business = Business.find(query_params[:business_id])
    @progress = current_customer.customer_progresses.find_by(business: @business)
    @rewards = current_customer.customer_rewards.where(business: @business)
  end

  private

  def query_params
    params.permit(:business_id)
  end
end
