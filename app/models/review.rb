# frozen_string_literal: true

class Review < ApplicationRecord
  self.table_name = 'reviews'
  belongs_to :business
  belongs_to :customer, optional: true, foreign_key: 'user_id', inverse_of: false
  has_one :qr_code_review, class_name: 'QrCode', dependent: :destroy
  # belongs_to :business

  scope :anon, -> { where(user_id: nil) }
end
