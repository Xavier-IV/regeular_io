# frozen_string_literal: true

class OmniauthSessionsController < ApplicationController
  def google_oauth2
    role = request.env['omniauth.params']['role']
    purpose = request.env['omniauth.params']['purpose']
    existing_user_id = request.env['omniauth.params']['user_id']

    resource = role == 'clients' ? Client : Customer
    redirect_url = role == 'clients' ? new_client_registration_url : new_customer_registration_url

    if role == 'clients' && purpose == 'link' && existing_user_id
      linked_omniauth = User.link_omniauth(request.env['omniauth.auth'], request.env['omniauth.params'], resource)
      flash[:success] = 'Succesfully linked with Google!'
      return redirect_to dashboards_account_path if linked_omniauth.persisted?
    end

    @user = User.from_omniauth(request.env['omniauth.auth'], resource)

    if @user.persisted?
      flash[:notice] = I18n.t 'devise.omniauth_callbacks.success', kind: 'Google'
      sign_in_and_redirect @user, event: :authentication
    else
      session['devise.google_data'] = request.env['omniauth.auth'].except('extra')
      redirect_to redirect_url, alert: @user.errors.full_messages.join("\n")
    end
  end

  def twitter
    role = request.env['omniauth.params']['role']
    purpose = request.env['omniauth.params']['purpose']
    existing_user_id = request.env['omniauth.params']['user_id']

    resource = role == 'clients' ? Client : Customer
    redirect_url = role == 'clients' ? new_client_registration_url : new_customer_registration_url

    if role == 'clients' && purpose == 'link' && existing_user_id
      linked_omniauth = User.link_omniauth(request.env['omniauth.auth'], request.env['omniauth.params'], resource)
      flash[:success] = 'Succesfully linked with Twitter!'
      return redirect_to dashboards_account_path if linked_omniauth.persisted?
    end

    @user = User.from_omniauth(request.env['omniauth.auth'], resource)

    if @user.persisted?
      flash[:notice] = I18n.t 'devise.omniauth_callbacks.success', kind: 'Twitter'
      sign_in_and_redirect @user, event: :authentication
    else
      session['devise.twitter_data'] = request.env['omniauth.auth'].except('extra')
      redirect_to redirect_url, alert: @user.errors.full_messages.join("\n")
    end
  end

  def after_sign_in_path_for(resource_or_scope)
    current_domain = request.hostname

    # https://github.com/heartcombo/devise/wiki/How-To:-%5BRedirect-back-to-current-page-after-sign-in,-sign-out,-sign-up,-update%5D#storelocation-to-the-rescue
    target_path = stored_location_for(resource_or_scope)
    target_path = dashboards_path if current_domain == Rails.application.credentials.dig(:host, :business)
    target_path = root_path if current_domain == Rails.application.credentials.dig(:host, :review)

    target_path
  end
end
