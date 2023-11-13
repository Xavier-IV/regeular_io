# frozen_string_literal: true

class Clients::Dashboards::CustomersController < ApplicationController
  include DashboardLayout

  def index
    @business = current_client.business
    @reviewer_progresses = current_client.business.customer_progresses
    @anon_reviews = current_client.business.anon_reviews
  end
end
