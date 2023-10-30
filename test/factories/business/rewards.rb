# frozen_string_literal: true

FactoryBot.define do
  factory :business_reward, class: 'Business::Reward' do
    kind { 'MyString' }
    value { 1.5 }
    created_by { nil }
    updated_by { nil }
    is_active { false }
    deactivated_at { '2023-10-29 00:35:36' }
  end
end
