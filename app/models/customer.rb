# frozen_string_literal: true

class Customer < User
  has_one_attached :avatar
end
