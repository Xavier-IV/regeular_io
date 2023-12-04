# frozen_string_literal: true

class Rider::Earning < ApplicationRecord
  self.table_name = 'rider_earnings'
  belongs_to :user
  belongs_to :rider_brand, class_name: 'Rider::Brand'
end
