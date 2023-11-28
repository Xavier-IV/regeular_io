# frozen_string_literal: true

class Business::Customer < ApplicationRecord
  belongs_to :user
  belongs_to :business
end
