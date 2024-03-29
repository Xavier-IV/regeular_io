# frozen_string_literal: true

class Clients::DashboardsController < ApplicationController
  include Dashboard::Layout
  include Dashboard::Auth

  before_action :authenticate_client!

  def index
    redirect_to clients_dashboards_onboarding_path(id: :onboard_company_name) unless onboarded?

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
    @approval = @business.business_approval_histories.unresolved.first

    return unless @business.present? && @business.reviews.present?

    @regulars = @business.customer_progresses.where('level > 0')
    @regulars_total = @business.customer_progresses.where('level > 0').count

    @reviews = current_client.business.reviews.count
  end

  private

  def onboarded?
    business = current_client.business
    business&.name.present? && business&.city.present? && business&.state.present?
  end
end
