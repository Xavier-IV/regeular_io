# frozen_string_literal: true

class AiResult < ApplicationRecord
  belongs_to :business
  belongs_to :user
end
