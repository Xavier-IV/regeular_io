# frozen_string_literal: true

class Admins::PasswordsController < Devise::PasswordsController
  layout 'admin/auth'

  def create
    if verify_recaptcha(action: 'forgot_password',
                        secret_key: Rails.application.credentials.dig(:recaptcha,
                                                                      :secret_key_admin))
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
