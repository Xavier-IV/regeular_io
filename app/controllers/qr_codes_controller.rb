# frozen_string_literal: true

class QrCodesController < ApplicationController
  before_action :find_qr_code
  layout 'qr_code'

  def show
    return if @qr.blank?

    @qr.scanned_times += 1
    @qr.save

    # Everytime someone scanned the code, replace to a new QR codes
    # to avoid spamming.
    replace_qr = @qr.business.qr_code_review.find_by(scanned_times: 0)
    replace_qr = @qr.business.qr_code_review.create if replace_qr.blank?
    Turbo::StreamsChannel.broadcast_replace_to([@qr.business, 'qr_codes_review'],
                                               target: 'codes',
                                               locals: { qr_code: replace_qr },
                                               partial: 'dashboards/qrs/reviews/review')

    case @qr.type
    when 'QrCode::Bank'
      redirect_to qr_codes_bank_path(reference: params[:reference])
    when 'QrCode::Review'
      redirect_to new_qr_codes_review_path(reference: params[:reference])
    end
  end

  private

  def find_qr_code
    qr_id = params[:reference]
    @qr = QrCode.find_by(id: qr_id)

    nil if @qr.blank?
  end
end
