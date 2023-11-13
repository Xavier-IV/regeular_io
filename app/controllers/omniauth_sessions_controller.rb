# frozen_string_literal: true

class OmniauthSessionsController < ApplicationController
  include CustomerHelper

  def google_oauth2
    omniauth_callback('google')
  end

  def twitter
    omniauth_callback('twitter')
  end

  def omniauth_callback(provider)
    role = request.env['omniauth.params']['role']
    purpose = request.env['omniauth.params']['purpose']
    existing_user_id = request.env['omniauth.params']['user_id']
    review_id = request.env['omniauth.params']['review_id']

    resource = role == 'clients' ? Client : Customer
    redirect_url = role == 'clients' ? new_client_registration_url : new_customer_registration_url

    if role == 'clients' && purpose == 'link' && existing_user_id
      linked_omniauth = User.link_omniauth(request.env['omniauth.auth'], request.env['omniauth.params'], resource)
      flash[:success] = "Successfully linked with #{provider.capitalize}!"
      return redirect_to dashboards_account_path if linked_omniauth.persisted?
    end

    if role == 'customers' && purpose == 'link_review_anonymous' && review_id.present?
      anon_omniauth = User.from_omniauth(request.env['omniauth.auth'], request.env['omniauth.params'], resource)
      review = Review.find(review_id)
      business = review.business
      if review.user_id.blank?
        flash[:success] = 'Your review is now linked to your account.'
        review.user_id = anon_omniauth.id
        add_pending_progress(anon_omniauth, business)
        review.save
      else
        flash[:success] = 'Review is already owned by someone else.'
      end

      return sign_in_and_redirect anon_omniauth, event: :authentication
    end

    @user = User.from_omniauth(request.env['omniauth.auth'], request.env['omniauth.params'], resource)

    if @user.persisted?
      flash[:notice] = I18n.t 'devise.omniauth_callbacks.success', kind: provider.capitalize
      sign_in_and_redirect @user, event: :authentication
    else
      session["devise.#{provider}_data"] = request.env['omniauth.auth'].except('extra')
      redirect_to redirect_url, alert: @user.errors.full_messages.join("\n")
    end
  end

  def after_sign_in_path_for(resource_or_scope)
    current_domain = request.hostname

    # https://github.com/heartcombo/devise/wiki/How-To:-%5BRedirect-back-to-current-page-after-sign-in,-sign-out,-sign-up,-update%5D#storelocation-to-the-rescue
    target_path = stored_location_for(resource_or_scope)
    target_path = dashboards_path if current_domain == Rails.application.credentials.dig(:host, :business)
    target_path = root_path if current_domain == Rails.application.credentials.dig(:host, :review)
    target_path = request.env['omniauth.params']['redirect_to'] if request.env['omniauth.params']['redirect_to']

    target_path
  end
end
