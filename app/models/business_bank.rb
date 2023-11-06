# frozen_string_literal: true

class BusinessBank < ApplicationRecord
  belongs_to :bank, class_name: 'Common::Bank'
  belongs_to :business

  validates :full_name, presence: true,
                        format: { with: /\A[A-Za-z0-9]+\z/, message: 'only allows letters and numbers' }
  validates :bank_id, presence: true
  validates :account_number, presence: true

  validates :account_number,
            uniqueness: { scope: :bank_id, message: 'has already been registered.' },
            format: { with: /\A[A-Za-z0-9]+\z/, message: 'only allows letters and numbers' }
end
