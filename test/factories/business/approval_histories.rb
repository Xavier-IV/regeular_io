# frozen_string_literal: true

FactoryBot.define do
  factory :business_approval_history, class: 'Business::ApprovalHistory' do
    business { nil }
    status { 'MyString' }
    client_remark { 'MyText' }
    system_remark { 'MyText' }
  end
end
