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

    Business::Customer.find_or_create_by(
      user_id: current_customer.id,
      business:
    )

    progress.gain_exp
  end

  def check_in_progress(current_customer, business)
    progress = Customer::Progress.find_or_create_by(user: current_customer, business:)

    progress.check_in_count = progress.check_in_count + 1
    progress.save

    Customer::CheckIn.create(
      user_id: current_customer.id,
      business:
    )

    Business::Customer.find_or_create_by(
      user_id: current_customer.id,
      business:
    )

    progress.gain_exp
  end
end
