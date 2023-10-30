# frozen_string_literal: true

module CustomerHelper
  def add_pending_progress(current_customer, business)
    progress = Customer::Progress.find_or_create_by(user: current_customer, business:)
    progress.rating_pending = count
    progress.save
  end
end
