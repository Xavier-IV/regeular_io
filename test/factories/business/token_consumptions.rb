# frozen_string_literal: true

FactoryBot.define do
  factory :business_token_consumption, class: 'Business::TokenConsumption' do
    kind { 'MyString' }
    business { nil }
  end
end
