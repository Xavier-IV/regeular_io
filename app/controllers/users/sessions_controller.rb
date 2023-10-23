# frozen_string_literal: true

class Users::SessionsController < Devise::SessionsController
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
    root_path
  end
end