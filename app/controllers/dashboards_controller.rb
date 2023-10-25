# frozen_string_literal: true

class DashboardsController < ApplicationController
  include Pundit::Authorization

  before_action :authenticate_client!
  layout 'business/dashboard'

  def index
    redirect_to dashboards_onboarding_path(id: :onboard_company_name) unless onboarded?

    @business = current_client.business
    @reviews = 0
    @regulars_total = 0
    return unless @business.present? && @business.reviews.present?

    @regulars = @business.reviewers.regular
    @regulars_total = ActiveRecord::Base.connection.exec_query(@regulars.to_sql).count

    @reviewers = current_client.business.reviewers
    @anon_reviews = current_client.business.anon_reviews
    @reviews = @reviewers.count + @anon_reviews.count
  end

  private

  def onboarded?
    business = current_client.business
    business&.name.present? && business&.city.present? && business&.state.present?
  end
end
