# frozen_string_literal: true

class Business::Statistic < ApplicationRecord
  belongs_to :business

  def regular_rating_percent
    return 0 if regular_rating_average.blank?

    regular_rating_average / 5 * 100
  end

  def customer_rating_percent
    return 0 if customer_rating_average.blank?

    customer_rating_average / 5 * 100
  end
end
