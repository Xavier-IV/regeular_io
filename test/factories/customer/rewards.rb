# frozen_string_literal: true

FactoryBot.define do
  factory :customer_reward, class: 'Customer::Reward' do
    kind { 'MyString' }
    value { 1.5 }
    given_at { '2023-10-29 00:47:25' }
    claimed_at { '2023-10-29 00:47:25' }
    likeness { 1 }
    business_reward { nil }
    business { nil }
  end
end
