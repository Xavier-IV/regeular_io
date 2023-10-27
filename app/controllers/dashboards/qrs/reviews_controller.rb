# frozen_string_literal: true

class Dashboards::Qrs::ReviewsController < ApplicationController
  include DashboardLayout

  def index
    @qr = current_client.business.qr_code_review.create
    @path = qr_code_url(reference: @qr.id)
  end

  def new; end

  def show; end

  def edit; end
end
