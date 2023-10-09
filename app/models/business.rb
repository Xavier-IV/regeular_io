# frozen_string_literal: true

class Business < ApplicationRecord
  has_one :user, dependent: :destroy
  has_one :business_bank, dependent: :destroy
  has_many :products, class_name: 'Business::Product', dependent: :destroy

  has_one_attached :logo
  has_one_attached :listing

  has_one :qr_code_bank, class_name: 'QrCode::Bank', dependent: :destroy
  has_one :qr_code_review, class_name: 'QrCode::Review', dependent: :destroy

  has_many :reviews, dependent: :destroy

  scope :listed, -> { joins(:listing_attachment).distinct.joins(:logo_attachment).distinct }
end
