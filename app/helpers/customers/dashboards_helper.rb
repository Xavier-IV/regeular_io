# frozen_string_literal: true

module Customers::DashboardsHelper
  def reward_name(reward)
    if reward.kind == 'Discount' && reward.value_type == 'percentage'
      number_to_percentage(reward.value, precision: 2)
    elsif reward.kind == 'Discount' && reward.value_type == 'fixed'
      number_to_currency(reward.value, locale: :ms)
    end
  end
end
