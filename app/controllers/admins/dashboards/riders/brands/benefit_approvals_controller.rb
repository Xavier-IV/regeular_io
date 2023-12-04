# frozen_string_literal: true

class Admins::Dashboards::Riders::Brands::BenefitApprovalsController < ApplicationController
  def approve
    benefit = Rider::BrandBenefit.find(params[:benefit_id])
    benefit.approved_at = Time.zone.now
    benefit.save

    if benefit.save
      redirect_to admins_dashboards_riders_brands_benefits_path, success: 'Benefit approved.'
    else
      redirect_to admins_dashboards_riders_brands_benefits_path, alert: benefit.errors.full_messages.join('. ')
    end
  end
end
