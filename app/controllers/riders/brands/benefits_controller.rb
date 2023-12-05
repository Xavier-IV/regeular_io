# frozen_string_literal: true

class Riders::Brands::BenefitsController < ApplicationController
  include Rider::Auth

  def create
    brand = Rider::Brand.find(params[:brand_id])

    benefit = brand.rider_brand_benefits.build(
      description: params[:description],
      created_by_id: current_rider.id
    )

    if benefit.save
      redirect_to rider_brand_path(slug: brand.slug),
                  success: 'Thank you, we will review your submission.'
    else
      redirect_to rider_brand_path(slug: brand.slug),
                  alert: benefit.errors.full_messages.join('. ')
    end
  end
end
