# frozen_string_literal: true

class Dashboards::Qrs::ReviewsController < ApplicationController
  include DashboardLayout

  def index
    @business = current_client.business
    @not_ready = @business.logo.blank? || @business.listing.blank? ||
                 @business.owner.confirmed_at.blank? || @business.open_at.blank? ||
                 @business.close_at.blank? || @business.gmap_link.blank? || @business.approved_at.blank?

    @qr = current_client.business.qr_code_review.find_by(scanned_times: 0)
    @qr = current_client.business.qr_code_review.create if @qr.blank?
    @path = qr_code_url(reference: @qr.id)
  end

  def new; end

  def show; end

  def edit; end
end
