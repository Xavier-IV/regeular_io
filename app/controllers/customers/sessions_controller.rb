# frozen_string_literal: true

class Customers::SessionsController < Devise::SessionsController
  layout 'business/auth'
  add_flash_types :success

  def create
    if verify_recaptcha(action: 'login')
      super
    else
      self.resource = resource_class.new(sign_in_params)
      respond_with_navigational(resource) { render :new }
    end
  end

  private

  def after_sign_in_path_for(_resource)
    stored_location_for(resource) || customer_root_path
  end
end
