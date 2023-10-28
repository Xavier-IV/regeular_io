# frozen_string_literal: true

class Omniauth < ApplicationRecord
  belongs_to :user, optional: true, inverse_of: :omniauths
end
