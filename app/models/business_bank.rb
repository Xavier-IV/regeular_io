# frozen_string_literal: true

class BusinessBank < ApplicationRecord
  belongs_to :bank, class_name: 'Common::Bank'
  belongs_to :business

  validates :full_name, presence: true
  validates :bank_id, presence: true
  validates :account_number, presence: true

  validates :account_number, uniqueness: { scope: :bank_id, message: 'has already been registered.' }
end
