# frozen_string_literal: true

FactoryBot.define do
  factory :business_subscription, class: 'Business::Subscription' do
    stripe_subscription_id { 'MyString' }
    business { nil }
    status { 'MyString' }
    plan { 'MyString' }
    start_date { '2023-11-19' }
    end_date { '2023-11-19' }
  end
end
