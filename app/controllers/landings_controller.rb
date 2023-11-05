# frozen_string_literal: true

class LandingsController < ApplicationController
  def index
    customer = Rails.application.credentials.dig(:host, :review)
    business = Rails.application.credentials.dig(:host, :business)

    mappings = {
      customer => customer_root_path(most: 'regular'),
      business => business_root_path
    }

    current_domain = request.hostname
    target_path = mappings[current_domain]

    if target_path
      redirect_to target_path
    else
      render plain: 'Domain not found', status: :not_found
    end
  end
end
