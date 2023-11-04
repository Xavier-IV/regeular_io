# frozen_string_literal: true

class Dashboards::ConfirmationsController < Devise::ConfirmationsController
  layout 'business/dashboard', only: [:new]
  before_action :authenticate_client!

  def new
    @sent_at = current_client.confirmation_sent_at
    super
  end

  def create
    current_client.confirmation_sent_at = Time.zone.now
    current_client.save
    super
  end

  def after_resending_confirmation_instructions_path_for(_resource_name)
    dashboards_path
  end
end
