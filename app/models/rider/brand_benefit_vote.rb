# frozen_string_literal: true

class Rider::BrandBenefitVote < ApplicationRecord
  self.table_name = 'rider_brand_benefit_votes'

  belongs_to :rider_brand, class_name: 'Rider::Brand'
  belongs_to :rider_brand_benefit, class_name: 'Rider::BrandBenefit'
  belongs_to :user
end
