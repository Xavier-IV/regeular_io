# frozen_string_literal: true

class Business::Reward < ApplicationRecord
  belongs_to :business
  belongs_to :created_by, class_name: 'Client'
  belongs_to :updated_by, class_name: 'Client'

  validates :kind, uniqueness: { scope: :business_id }
  validates :business_id, presence: true

  validates :value, presence: true
  validates :value_type, presence: true, if: -> { value.present? }
  validates :capped_amount, presence: true, if: -> { value_type == 'percentage' && kind == 'Discount' }
  validates :min_order_amount, presence: true, if: -> { kind == 'Discount' }
end
