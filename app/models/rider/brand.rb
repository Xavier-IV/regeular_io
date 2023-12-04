# frozen_string_literal: true

class Rider::Brand < ApplicationRecord
  self.table_name = 'rider_brands'

  has_many :rider_brand_benefits, class_name: 'Rider::BrandBenefit', foreign_key: 'rider_brand_id',
                                  dependent: :destroy,
                                  inverse_of: false
  has_many :rider_brand_benefit_statistics, class_name: 'Rider::BrandBenefitStatistic',
                                            dependent: :destroy,
                                            inverse_of: false
end
