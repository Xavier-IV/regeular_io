# frozen_string_literal: true

class Clients::Dashboards::Qrs::ReviewsController < ApplicationController
  include Dashboard::Layout
  include Dashboard::Auth
  include Dashboard::Verified

  def index
    @business = current_client.business
    @not_ready = @business.status != 'approved' && (
      @business.logo.blank? || @business.listing.blank? ||
        @business.owner.confirmed_at.blank? || @business.open_at.blank? ||
        @business.close_at.blank? || @business.gmap_link.blank?
    )
    @progress = current_client.client_progresses.onboarded?([
                                                              'onboarding.get_started',
                                                              'onboarding.verified_email',
                                                              'onboarding.has_logo',
                                                              'onboarding.has_listing_image',
                                                              'onboarding.has_operating_hours',
                                                              'onboarding.has_gmap_link'
                                                            ])
    @qr = current_client.business.qr_code_review.find_by(scanned_times: 0)
    @qr = current_client.business.qr_code_review.create if @qr.blank?
    @path = qr_code_url(reference: @qr.id)
  end

  def new; end

  def show; end

  def edit; end
end
