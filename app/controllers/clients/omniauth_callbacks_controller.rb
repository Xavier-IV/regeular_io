# frozen_string_literal: true

class Clients::OmniauthCallbacksController < Devise::OmniauthCallbacksController
  def google_oauth2
    @user = User.from_omniauth(request.env['omniauth.auth'], Client)

    if @user.persisted?
      flash[:notice] = I18n.t 'devise.omniauth_callbacks.success', kind: 'Google'
      sign_in_and_redirect @user, event: :authentication
    else
      session['devise.google_data'] = request.env['omniauth.auth'].except('extra')
      redirect_to new_client_registration_url, alert: @user.errors.full_messages.join("\n")
    end
  end

  def twitter
    @user = User.from_omniauth(request.env['omniauth.auth'], Client)

    if @user.persisted?
      flash[:notice] = I18n.t 'devise.omniauth_callbacks.success', kind: 'Twitter'
      sign_in_and_redirect @user, event: :authentication
    else
      session['devise.twitter_data'] = request.env['omniauth.auth'].except('extra')
      redirect_to new_client_registration_url, alert: @user.errors.full_messages.join("\n")
    end
  end

  def after_sign_in_path_for(resource_or_scope)
    current_domain = request.hostname

    # https://github.com/heartcombo/devise/wiki/How-To:-%5BRedirect-back-to-current-page-after-sign-in,-sign-out,-sign-up,-update%5D#storelocation-to-the-rescue
    target_path = stored_location_for(resource_or_scope)
    target_path = dashboards_path if current_domain == Rails.application.credentials.dig(:host, :business)

    target_path
  end
end
