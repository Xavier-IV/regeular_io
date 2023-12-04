# frozen_string_literal: true

class Rider::BrandBenefitStatistic < ApplicationRecord
  self.table_name = 'rider_brand_benefit_statistics'

  belongs_to :rider_brand, class_name: 'Rider::Brand'
  belongs_to :rider_brand_benefit, class_name: 'Rider::BrandBenefit'
end
