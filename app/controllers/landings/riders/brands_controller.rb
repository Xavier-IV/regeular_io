# frozen_string_literal: true

class Landings::Riders::BrandsController < ApplicationController
  layout 'rider'

  def show
    @brand = Rider::Brand.find_by(slug: params[:slug])
    @total_benefits = Rider::BrandBenefitStatistic
                      .joins(:rider_brand_benefit)
                      .where(
                        rider_brand_id: @brand.id
                      )
                      .where.not(rider_brand_benefits: {
                                   approved_at: nil
                                 }).count

    @benefits = if rider_signed_in?
                  Rider::BrandBenefitStatistic
                    .joins(:rider_brand_benefit)
                    .where(
                      rider_brand_id: @brand.id
                    ).order(total_votes: :desc, created_at: :asc)
                else
                  Rider::BrandBenefitStatistic
                    .joins(:rider_brand_benefit)
                    .where.not(rider_brand_benefits: {
                                 approved_at: nil
                               })
                    .where(
                      rider_brand_id: @brand.id
                    ).order(total_votes: :desc, created_at: :asc)
                    .limit(5)
                end

    @my_votes = []
    return unless rider_signed_in?

    @my_votes = Rider::BrandBenefitVote.where(
      rider_brand_id: @brand.id,
      user_id: current_rider.id
    )
  end
end
