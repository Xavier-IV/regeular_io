# frozen_string_literal: true

class Admins::DashboardsController < ApplicationController
  include AdminLayout

  def index
    redirect_to admins_dashboard_path
  end

  def show
    @pending_businesses = Business.state_pending_review
    @new_businesses = Business.state_new.order(created_at: :desc)
  end
end
