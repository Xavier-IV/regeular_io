# frozen_string_literal: true

class Riders::SessionsController < Devise::SessionsController
  layout 'rider/auth'
  add_flash_types :success

  def new
    redirect_to rider_root_path
  end

  def create
    if verify_recaptcha(action: 'login')
      super
    else
      self.resource = resource_class.new(sign_in_params)
      respond_with_navigational(resource) { render :new }
    end
  end

  private

  def after_sign_in_path_for(resource)
    stored_location_for(resource) || rider_root_path
  end
end
