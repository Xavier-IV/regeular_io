# frozen_string_literal: true

class Riders::PasswordsController < Devise::PasswordsController
  layout 'rider/auth'

  def new
    redirect_to rider_root_path
  end

  def create
    if verify_recaptcha(action: 'forgot_password')
      super
    else
      self.resource = resource_class.new(query_params[:user])
      respond_with_navigational(resource) { render :new }
    end
  end

  private

  def query_params
    params.permit(:user)
  end
end
