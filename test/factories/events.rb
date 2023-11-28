# frozen_string_literal: true

FactoryBot.define do
  factory :event do
    name { 'MyString' }
    date { '2023-11-23' }
    description { 'MyText' }
  end
end
