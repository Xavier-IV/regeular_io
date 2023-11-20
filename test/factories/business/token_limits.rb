# frozen_string_literal: true

FactoryBot.define do
  factory :business_token_limit, class: 'Business::TokenLimit' do
    kind { 'MyString' }
    limit { 1 }
    limit_by { 'MyString' }
    business { nil }
  end
end
