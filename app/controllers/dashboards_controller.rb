# frozen_string_literal: true

class DashboardsController < ApplicationController
  include Pundit::Authorization

  before_action :authenticate_user!
  layout 'business/dashboard'

  def index
    redirect_to dashboards_onboarding_path(id: :onboard_company_name) unless onboarded?

    @business = current_user.business
    @reviews = 0
    return unless @business.present? && @business.reviews.present?

    @reviews = @business.reviews.count
  end

  private

  def onboarded?
    business = current_user.business
    business&.name.present? && business&.city.present? && business&.state.present?
  end
end
