# frozen_string_literal: true

class Riders::Brands::UpvotesController < ApplicationController
  include Rider::Auth

  def create
    brand = Rider::Brand.find(params[:brand_id])
    benefit = Rider::BrandBenefit.find(params[:benefit_id])

    vote = Rider::BrandBenefitVote.find_or_create_by(
      rider_brand_id: brand.id,
      rider_brand_benefit_id: benefit.id,
      user_id: current_rider.id
    )

    if benefit.approved_at.blank?
      return redirect_to(rider_brand_path(slug: brand.slug), alert: 'Please wait for approval')
    end

    time_diff = Time.zone.now - vote.updated_at

    if vote.direction.present? && time_diff < 5.seconds
      return redirect_to(rider_brand_path(slug: brand.slug), alert: "Please wait a #{(5 - time_diff).floor} seconds.")
    end

    vote.direction = if vote.direction.present? && vote.direction == 1
                       0
                     elsif vote.direction.present? && vote.direction < 1
                       vote.direction + 1
                     else
                       1
                     end
    vote.save

    all_sum = Rider::BrandBenefitVote.where(rider_brand_benefit_id: benefit.id).sum(:direction)
    statistic = Rider::BrandBenefitStatistic.find_or_create_by(
      rider_brand_id: brand.id,
      rider_brand_benefit_id: benefit.id
    )
    statistic.total_votes = all_sum
    statistic.save

    redirect_to rider_brand_path(slug: brand.slug)
  end
end
