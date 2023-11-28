# frozen_string_literal: true

class QrCodes::CheckInsController < ApplicationController
  include CustomerHelper

  def new
    @qr = QrCode::CheckIn.find(query_params[:reference])
    @business = @qr&.business
    @checked_in = false

    return unless customer_signed_in?

    @recent_check_in = Customer::CheckIn.where(user_id: current_customer.id).order(created_at: :desc).first

    if @recent_check_in.present? && (Time.zone.now - @recent_check_in.created_at) < 10.minutes
      flash.now[:notice] = "You've already checked in!"
    else
      check_in_progress(current_customer, @business)
      flash.now[:success] = "You've successfully check in!"
    end

    @checked_in = true
  end

  private

  def query_params
    params.permit(:id, :reference)
  end
end
