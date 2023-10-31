# frozen_string_literal: true

class Customer::Progress::ExperienceComponent < ViewComponent::Base
  def initialize(progress:)
    super
    @customer_progress = progress
  end
end
