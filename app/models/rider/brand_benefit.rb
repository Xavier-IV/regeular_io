# frozen_string_literal: true

class Rider::BrandBenefit < ApplicationRecord
  self.table_name = 'rider_brand_benefits'

  belongs_to :created_by, class_name: 'Rider'
  belongs_to :rider_brand, class_name: 'Rider::Brand'
  has_one :rider_brand_benefit_statistic, class_name: 'Rider::BrandBenefitStatistic',
                                          dependent: :destroy,
                                          inverse_of: false,
                                          foreign_key: 'rider_brand_benefit_id'
  has_many :rider_brand_benefit_votes, class_name: 'Rider::BrandBenefitVote',
                                       inverse_of: false,
                                       foreign_key: 'rider_brand_benefit_id', dependent: :destroy

  after_create :prepare_statistic

  def total_all_votes
    rider_brand_benefit_votes.sum(:direction)
  end

  private

  def prepare_statistic
    create_rider_brand_benefit_statistic(
      rider_brand_id: rider_brand.id,
      total_votes: 0
    )
  end
end
