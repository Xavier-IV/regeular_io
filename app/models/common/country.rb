# frozen_string_literal: true

class Common::Country < ApplicationRecord
  has_many :states, class_name: 'Common::State', dependent: :destroy
end
