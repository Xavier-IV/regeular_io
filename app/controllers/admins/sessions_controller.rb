# frozen_string_literal: true

class Admins::SessionsController < Devise::SessionsController
  layout 'admin/auth'
  add_flash_types :success

  def create
    if verify_recaptcha(action: 'login', secret_key: Rails.application.credentials.dig(:recaptcha, :secret_key_admin))
      super
    else
      self.resource = resource_class.new(sign_in_params)
      respond_with_navigational(resource) { render :new }
    end
  end

  private

  def after_sign_in_path_for(_resource)
    stored_location_for(resource) || new_admin_session
  end
end
