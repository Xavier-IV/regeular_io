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

    return if @business.blank?

    @not_ready = @business.logo.blank? || @business.listing.blank? ||
                 @business.owner.confirmed_at.blank? || @business.open_at.blank? ||
                 @business.close_at.blank? || @business.gmap_link.blank?

    @progress = current_client.client_progresses.onboarded?([
                                                              'onboarding.get_started',
                                                              'onboarding.verified_email',
                                                              'onboarding.has_logo',
                                                              'onboarding.has_listing_image',
                                                              'onboarding.has_operating_hours',
                                                              'onboarding.has_gmap_link'
                                                            ])

    return unless @business.present? && @business.reviews.present?

    @approval = @business.business_approval_histories.unresolved.first

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
