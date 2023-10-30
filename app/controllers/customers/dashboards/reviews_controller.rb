# frozen_string_literal: true

class Customers::Dashboards::ReviewsController < ApplicationController
  include Pundit::Authorization

  before_action :authenticate_customer!
  layout 'customer/dashboard'

  def index
    @reviews = current_customer.reviews.where(business_id: params[:business_id])
  end
end
