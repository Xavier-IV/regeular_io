# frozen_string_literal: true

FactoryBot.define do
  factory :business_statistic, class: 'Business::Statistic' do
    business { nil }
    total_regular { 1 }
    total_customer { 1 }
    regular_rating_average { 1.5 }
    customer_rating_average { 1.5 }
  end
end
