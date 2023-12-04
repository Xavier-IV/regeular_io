# frozen_string_literal: true

class Landings::RidersController < ApplicationController
  layout 'rider'

  def index
    @brands = Rider::Brand.all

    @benefits = Rider::BrandBenefit.where.not(approved_at: nil).order(created_at: :desc).limit(5)
  end
end
