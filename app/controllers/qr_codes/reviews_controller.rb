# frozen_string_literal: true

class QrCodes::ReviewsController < QrCodesController
  def new
    @rating = Review.new
    @qr = QrCode.find_by(id: params[:reference])
    @business = @qr&.business
  end

  def create
    business = Business.find_by(id: review_params[:business_id])
    @rating = business.reviews.create(rating: review_params[:rating], description: review_params[:description])
    redirect_to qr_codes_review_path(id: @rating.id)
  end

  def show
    @review = Review.find(params[:id])
  end

  private

  def review_params
    params.require(:review).permit(:rating, :description, :business_id)
  end
end
