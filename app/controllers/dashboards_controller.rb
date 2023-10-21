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

    @reviewers = current_user.business.reviewers
    @anon_reviews = current_user.business.anon_reviews
    @reviews = @reviewers.count + @anon_reviews.count
  end

  private

  def onboarded?
    business = current_user.business
    business&.name.present? && business&.city.present? && business&.state.present?
  end
end
