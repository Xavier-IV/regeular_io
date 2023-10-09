# frozen_string_literal: true

class Dashboard::Review::ReviewCardComponent < ViewComponent::Base
  def initialize(rating:, description:)
    super
    @rating = rating
    @description = description
  end
end
