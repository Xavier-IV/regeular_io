# frozen_string_literal: true

module CustomerHelper
  def add_pending_progress(current_customer, business)
    ratings = current_customer.reviews.where(business_id: business.id)
                              .map(&:rating)
    rating_average = ratings.reduce(:+).to_f / ratings.length

    progress = Customer::Progress.find_or_create_by(user: current_customer, business:)

    progress.rating_average = rating_average
    progress.rating_count = ratings.length
    progress.save

    progress.gain_exp
  end
end
