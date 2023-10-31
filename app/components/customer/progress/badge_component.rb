# frozen_string_literal: true

class Customer::Progress::BadgeComponent < ViewComponent::Base
  def initialize(progress:)
    super
    @customer_progress = progress
  end
end
