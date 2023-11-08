# frozen_string_literal: true

class Admins::RegistrationsController < Devise::RegistrationsController
  layout 'admin/auth'
  add_flash_types :success

  def create
    if verify_recaptcha(action: 'register')
      super
    else
      self.resource = Client.new(sign_up_params)
      respond_with_navigational(resource) { render :new }
    end
  end
end
