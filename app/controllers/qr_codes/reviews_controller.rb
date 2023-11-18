# frozen_string_literal: true

class QrCodes::ReviewsController < QrCodesController
  include CustomerHelper

  def new
    @qr = QrCode::Review.find(query_params[:reference])
    @rating = Review.find_by(qr_code_id: @qr.id)
    return redirect_to qr_codes_review_path(id: @rating.id) if @rating.present?

    @rating = Review.new(qr_code_id: @qr.id)
    @business = @qr&.business
    @rewards = @business.business_rewards
    @rewards_discounts = @business.business_rewards.kind_discounts
    @rewards_birthdays = @business.business_rewards.kind_birthdays

    @customer_progress = current_customer.customer_progresses.find_by(business: @business) if customer_signed_in?
  end

  def create
    find_business_and_qr_code

    return rate_limit_redirect if rate_limit_exceeded?

    return redirect_to_existing_review if @rating.present?

    create_and_broadcast_review

    redirect_to qr_codes_review_path(id: @rating.id)
  end

  def show
    @review = Review.find(query_params[:id])
    @business = @review.business
    @rewards = @business.business_rewards
    @rewards_discounts = @business.business_rewards.kind_discounts
    @rewards_birthdays = @business.business_rewards.kind_birthdays
    @customer_progress = current_customer.customer_progresses.find_by(business: @business) if customer_signed_in?
  end

  private

  def query_params
    params.permit(:id, :reference)
  end

  def review_params
    params.require(:review).permit(:rating, :description, :business_id, :qr_code_id)
  end

  def find_business_and_qr_code
    @business = Business.find_by(id: review_params[:business_id])
    @qr_code = QrCode::Review.find(review_params[:qr_code_id])
    @rating = Review.find_by(qr_code_id: @qr_code.id)
  end

  def rate_limit_redirect
    if customer_signed_in?
      flash_message = 'Please wait 10 minutes.'
      10.minutes
    else
      flash_message = 'Please wait 5 seconds.'
      5.seconds
    end

    flash[:notice] = flash_message
    redirect_to new_qr_codes_review_path(reference: @qr_code.id), status: :unprocessable_entity
  end

  def rate_limit_exceeded?
    return false unless Rails.env.production?

    latest_review = if customer_signed_in?
                      current_customer.reviews.order(created_at: :desc).first
                    else
                      @business.reviews.where(user_id: nil).order(created_at: :desc).first
                    end
    latest_review && (Time.zone.now - latest_review.created_at) <= time_limit
  end

  def redirect_to_existing_review
    redirect_to qr_codes_review_path(id: @rating.id), notice: 'Review was already submitted.'
  end

  def create_and_broadcast_review
    @rating = @business.reviews.build(
      rating: review_params[:rating],
      description: review_params[:description],
      qr_code_id: @qr_code.id
    )
    @rating.customer = current_customer if current_customer.present?
    @rating.save

    replace_qr = @business.qr_code_review.find_by(scanned_times: 0)
    replace_qr = @business.qr_code_review.create if replace_qr.blank?
    Turbo::StreamsChannel.broadcast_replace_to([@business, 'qr_codes_review'],
                                               target: 'codes',
                                               locals: { qr_code: replace_qr },
                                               partial: 'clients/dashboards/qrs/reviews/review')
  end
end
