# frozen_string_literal: true

FactoryBot.define do
  factory :ai_result do
    kind { 'MyString' }
    input_text { 'MyText' }
    output_text { 'MyText' }
    api_response { 'MyText' }
    business { nil }
    user { nil }
  end
end
