# frozen_string_literal: true

class Dashboards::ReviewsController < DashboardsController
  def index
    @reviews = current_user.business.reviews
  end
end
