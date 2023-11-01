# frozen_string_literal: true

class QrCodes::ReviewsController < QrCodesController
  include CustomerHelper

  def new
    @qr = QrCode::Review.find(params[:reference])
    @rating = Review.find_by(qr_code_id: @qr.id)
    return redirect_to qr_codes_review_path(id: @rating.id) if @rating.present?

    @rating = Review.new(qr_code_id: @qr.id)
    @business = @qr&.business
    @rewards = @business.business_rewards
    @customer_progress = current_customer.customer_progresses.find_by(business: @business) if customer_signed_in?
  end

  def create
    business = Business.find_by(id: review_params[:business_id])
    qr_code = QrCode::Review.find(review_params[:qr_code_id])
    @rating = Review.find_by(qr_code_id: qr_code.id)

    # TODO: Ratelimit by 15 mins

    if Rails.env.production?
      if customer_signed_in?
        latest_review = current_customer.reviews.order(created_at: :desc).first
        time_limit = 10.minutes
      else
        latest_review = business.reviews.where(user_id: nil).order(created_at: :desc).first
        time_limit = 5.seconds
      end

      if latest_review && (Time.zone.now - latest_review.created_at) <= time_limit
        flash[:notice] = customer_signed_in? ? 'Please wait 10 minutes.' : 'Please wait 5 seconds.'
        return redirect_to new_qr_codes_review_path(reference: qr_code.id), status: :unprocessable_entity
      end
    end

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
    @business = @review.business
    @rewards = @business.business_rewards
    @customer_progress = current_customer.customer_progresses.find_by(business: @business) if customer_signed_in?
  end

  private

  def review_params
    params.require(:review).permit(:rating, :description, :business_id, :qr_code_id)
  end
end
