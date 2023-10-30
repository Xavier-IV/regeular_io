# frozen_string_literal: true

FactoryBot.define do
  factory :customer_progress, class: 'Customer::Progress' do
    user { nil }
    business { nil }
    rating_average { 1.5 }
    rating_count { 1 }
    rating_pending { 1 }
    level { 'MyString' }
  end
end
