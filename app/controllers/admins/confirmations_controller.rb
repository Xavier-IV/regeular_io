# frozen_string_literal: true

class Admins::ConfirmationsController < Devise::ConfirmationsController
  layout 'admin/auth'
  add_flash_types :success

  def show
    super do
      sign_in(resource) if resource.errors.empty?
    end
  end

  def create
    if verify_recaptcha(action: 'confirmations',
                        secret_key: Rails.application.credentials.dig(:recaptcha,
                                                                      :secret_key_admin))
      super
    else
      self.resource = resource_class.new(query_params[:user])
      respond_with_navigational(resource) { render :new }
    end
  end

  def after_confirmation_path_for(_, _)
    clients_dashboards_onboarding_path(id: :onboard_company_name)
  end

  private

  def query_params
    params.permit(:user)
  end
end
