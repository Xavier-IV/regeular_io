# frozen_string_literal: true

class Customers::PasswordsController < Devise::PasswordsController
  layout 'business/auth'

  def create
    if verify_recaptcha(action: 'forgot_password')
      super
    else
      self.resource = resource_class.new(params[:user])
      respond_with_navigational(resource) { render :new }
    end
  end
end
