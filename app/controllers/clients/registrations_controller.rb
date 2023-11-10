# frozen_string_literal: true

class Clients::RegistrationsController < Devise::RegistrationsController
  layout 'business/auth'
  add_flash_types :success

  def create
    if verify_recaptcha(action: 'register')
      super
    else
      self.resource = Client.new(sign_up_params)
      respond_with_navigational(resource) { render :new }
    end
  end

  private

  def after_sign_in_path_for(_resource)
    dashboards_path
  end
end
