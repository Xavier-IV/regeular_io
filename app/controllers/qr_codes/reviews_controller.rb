# frozen_string_literal: true

class QrCodes::ReviewsController < QrCodesController
  include CustomerHelper

  def new
    @qr = QrCode::Review.find(params[:reference])
    @rating = Review.find_by(qr_code_id: @qr.id)
    return redirect_to qr_codes_review_path(id: @rating.id) if @rating.present?

    @rating = Review.new(qr_code_id: @qr.id)
    @business = @qr&.business
  end

  def create
    business = Business.find_by(id: review_params[:business_id])
    qr_code = QrCode::Review.find(review_params[:qr_code_id])
    @rating = Review.find_by(qr_code_id: qr_code.id)

    return redirect_to qr_codes_review_path(id: @rating.id), notice: 'Review was already submitted.' if @rating.present?

    @rating = business.reviews.build(rating: review_params[:rating],
                                     description: review_params[:description],
                                     qr_code_id: qr_code.id)
    @rating.customer = current_customer if current_customer.present?
    @rating.save

    replace_qr = business.qr_code_review.find_by(scanned_times: 0)
    replace_qr = business.qr_code_review.create if replace_qr.blank?
    Turbo::StreamsChannel.broadcast_replace_to([business, 'qr_codes_review'],
                                               target: 'codes',
                                               locals: { qr_code: replace_qr },
                                               partial: 'dashboards/qrs/reviews/review')

    redirect_to qr_codes_review_path(id: @rating.id)
  end

  def show
    @review = Review.find(params[:id])
  end

  private

  def review_params
    params.require(:review).permit(:rating, :description, :business_id, :qr_code_id)
  end
end
