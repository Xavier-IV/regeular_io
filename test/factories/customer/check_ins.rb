# frozen_string_literal: true

FactoryBot.define do
  factory :customer_check_in, class: 'Customer::CheckIn' do
    user { nil }
  end
end
