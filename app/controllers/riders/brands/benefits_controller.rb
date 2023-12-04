# frozen_string_literal: true

class Riders::Brands::BenefitsController < ApplicationController
  include Rider::Auth

  def create
    brand = Rider::Brand.find(params[:brand_id])

    brand.rider_brand_benefits.create(
      description: params[:description],
      created_by_id: current_rider.id
    )

    return unless brand.persisted?

    redirect_to rider_brand_path(slug: brand.slug),
                success: 'Thank you, we will review your submission.'
  end
end
