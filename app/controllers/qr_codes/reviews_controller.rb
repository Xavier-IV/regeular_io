# frozen_string_literal: true

class QrCodes::ReviewsController < QrCodesController
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

    return redirect_to qr_codes_review_path(id: @rating.id) if @rating.present?

    @rating = business.reviews.create(rating: review_params[:rating], description: review_params[:description],
                                      qr_code_id: qr_code.id)
    if current_customer.present?
      @rating.customer = current_customer
      @rating.save
    end

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
