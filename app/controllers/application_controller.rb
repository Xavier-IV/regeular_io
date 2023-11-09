# frozen_string_literal: true

class ApplicationController < ActionController::Base
  add_flash_types :success

  before_action :store_user_location!, if: :storable_location?

  def index
    redirect_to admins_dashboard_path
  end

  private

  def storable_location?
    request.get? &&
      is_navigational_format? &&
      !devise_controller? &&
      !request.xhr? &&
      !turbo_frame_request?
  end

  def store_user_location!
    current_domain = request.hostname
    is_business = current_domain == Rails.application.credentials.dig(:host, :business)
    store_location_for(is_business ? :client : :customer, request.fullpath)
  end
end
