# frozen_string_literal: true

class Clients::Dashboards::Qrs::ReviewsController < ApplicationController
  include Dashboard::Layout
  include Dashboard::Auth

  def index
    @business = current_client.business
    @not_ready = @business.status != 'approved'

    @qr = current_client.business.qr_code_review.find_by(scanned_times: 0)
    @qr = current_client.business.qr_code_review.create if @qr.blank?
    @path = qr_code_url(reference: @qr.id)
  end

  def new; end

  def show; end

  def edit; end
end
