# frozen_string_literal: true

class Customers::RegistrationsController < Devise::RegistrationsController
  layout 'business/auth'
  add_flash_types :success

  def create
    if verify_recaptcha(action: 'register')
      super
    else
      self.resource = Customer.new(sign_up_params)
      respond_with_navigational(resource) { render :new }
    end
  end

  private

  def after_sign_in_path_for(resource)
    stored_location_for(resource) || customer_root_path
  end
end
