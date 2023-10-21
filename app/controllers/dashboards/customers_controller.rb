class Dashboards::CustomersController < ApplicationController
  include DashboardLayout

  def index
    @reviewers = current_user.business.reviewers
    @anon_reviews = current_user.business.anon_reviews
  end
end
