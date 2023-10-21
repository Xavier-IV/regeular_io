# frozen_string_literal: true

class Review < ApplicationRecord
  belongs_to :user, optional: true
  belongs_to :business

  scope :anon, -> { where(user_id: nil)}
end
