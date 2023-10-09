# frozen_string_literal: true

class Business::Product < ApplicationRecord
  belongs_to :business

  has_one_attached :image
end
