# frozen_string_literal: true

class Dashboards::ConfirmationsController < Devise::ConfirmationsController
  layout 'business/dashboard', only: [:new]
  before_action :authenticate_user!

  def after_resending_confirmation_instructions_path_for(_resource_name)
    dashboards_path
  end
end
