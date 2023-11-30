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
      user_name = current_customer.first_name.present? ? current_customer.first_name : 'A user'
      total_check_in = Customer::CheckIn
                         .where("created_at >= ?", Time.zone.today.beginning_of_day)
                         .where(business_id: @business.id)
                         .count
      # TODO: Release on 50 registered users
      # @business.owner.push_subscriptions.each do |sub|
      #   PushNotificationService.send_notification(
      #     'Customer signed in',
      #     "#{user_name} checked in. You have #{total_check_in} customers today!",
      #     sub
      #   )
      # end
      flash.now[:success] = "You've successfully check in!"
    end

    replace_qr = @business.qr_code_check_ins.find_by(scanned_times: 0)
    replace_qr = @business.qr_code_check_ins.create if replace_qr.blank?
    Turbo::StreamsChannel.broadcast_replace_to([@business, 'check_ins'],
                                               target: 'codes',
                                               locals: { qr_code: replace_qr },
                                               partial: 'clients/dashboards/qrs/check_ins/code')

    @checked_in = true
  end

  private

  def query_params
    params.permit(:id, :reference)
  end
end
