# frozen_string_literal: true

class Common::Bank < ApplicationRecord
  has_many :business_banks, dependent: :destroy
end
