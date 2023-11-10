# frozen_string_literal: true

FactoryBot.define do
  factory :progress do
    user { nil }
    type { '' }
    progress_type { 'MyString' }
    completed_at { '2023-11-10 10:26:44' }
  end
end
