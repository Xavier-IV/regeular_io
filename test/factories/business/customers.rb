# frozen_string_literal: true

FactoryBot.define do
  factory :business_customer, class: 'Business::Customer' do
    user { nil }
    business { nil }
  end
end
