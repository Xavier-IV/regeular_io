# frozen_string_literal: true

class Dashboards::OnboardingsController < ApplicationController
  before_action :authenticate_client!

  include Wicked::Wizard

  steps :onboard_company_name, :onboard_company_location, :onboard_complete

  def show
    if current_client.business.present? &&
       current_client.business.name.present? &&
       current_client.business.city.present? &&
       current_client.business.state.present? &&
       step != :onboard_complete
      return redirect_to dashboards_path
    end

    has_business = current_client.business.present?
    @business = has_business ? current_client.business : current_client.build_business
    @states = Common::Country.find_by(name: 'Malaysia').states
    @cities = []
    render_wizard
  end

  def create
    case step
    when :onboard_company_name
      if params[:business][:name].blank?
        flash[:alert] = 'Business name cannot be empty'
        redirect_to_next(:onboard_company_name)
      else
        current_client.create_business(name: params[:business][:name])
        current_client.save
        Rails.logger.debug current_client.to_json
        Rails.logger.debug current_client.business.to_json
        Rails.logger.debug 'HERE TOO!'
        redirect_to_next(:onboard_company_location)
      end
    when :onboard_company_location
      if current_client.business.blank?
        flash[:alert] = 'Business name cannot be empty'
        redirect_to_next(:onboard_company_name)
      end
    else
      redirect_to dashboards_onboarding_path, alert: 'Something went wrong'
    end
  end

  def update
    Rails.logger.debug current_client.business
    Rails.logger.debug 'HEY HERE!'
    case step
    when :onboard_company_name
      current_client.business.update(name: params[:business][:name])
      redirect_to_next(:onboard_company_location)
    when :onboard_company_location
      if current_client.business.blank?
        flash[:alert] = 'Business name cannot be empty'
        return redirect_to_next(:onboard_company_location)
      end

      if params[:business][:city].present? &&
         params[:business][:state].present? &&
         current_client.business.update(city: params[:business][:city], state: params[:business][:state])
        redirect_to_next(:onboard_complete)
      else
        flash[:alert] = 'State and city cannot be empty.'
        redirect_to_next(:onboard_company_location)
      end

    end
  end
end
