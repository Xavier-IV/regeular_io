# frozen_string_literal: true

class Common::State < ApplicationRecord
  belongs_to :country, class_name: 'Common::Country'
  has_many :cities, class_name: 'Common::City', dependent: :destroy
end
