# frozen_string_literal: true

class Dashboards::ProgressesController < ApplicationController
  def create
    current_client.client_progresses.create(
      progress_type: params[:progress_type],
      completed_at: Time.zone.now
    )
    # return unless progress.persisted? && progress.progress_type == 'onboarding.get_started'

    redirect_to dashboards_path
  end
end
