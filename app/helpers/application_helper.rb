# frozen_string_literal: true

module ApplicationHelper
  def business_regular_percent(business)
    return 0.0 if business.business_statistic.regular_rating_average.blank?

    number_with_precision(business.business_statistic.regular_rating_average, precision: 1)
  end

  def business_customer_percent(business)
    return 0.0 if business.business_statistic.customer_rating_average.blank?

    number_with_precision(business.business_statistic.customer_rating_average, precision: 1)
  end
end
