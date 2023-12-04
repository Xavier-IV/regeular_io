# frozen_string_literal: true

class Admins::Dashboards::Riders::Brands::BenefitsController < ApplicationController
  include AdminLayout

  def index
    @benefits = Rider::BrandBenefit.where(approved_at: nil).order(created_at: :asc)
  end
end
