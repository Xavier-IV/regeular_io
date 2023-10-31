# frozen_string_literal: true

class Customer::Progress::LevelComponent < ViewComponent::Base
  def initialize(progress:)
    super
    @customer_progress = progress
  end
end
