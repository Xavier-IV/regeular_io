# frozen_string_literal: true

class Dashboards::ProgressesController < ApplicationController
  def create
    return redirect_to dashboards_path unless %w[onboarding.get_started
                                                 onboarding.verified_email
                                                 onboarding.has_logo
                                                 onboarding.has_listing_image
                                                 onboarding.has_operating_hours
                                                 onboarding.has_gmap_link].include?(params[:progress_type].to_s)

    current_client.client_progresses.create(
      progress_type: params[:progress_type],
      completed_at: Time.zone.now
    )

    redirect_to dashboards_path
  end
end
