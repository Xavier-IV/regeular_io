# frozen_string_literal: true

module Dashboards
  class OnboardingsController < DashboardsController
    layout 'business/onboarding'

    include Wicked::Wizard

    steps :onboard_company_name, :onboard_company_location, :onboard_complete

    def show
      Rails.logger.debug "Steps:? #{step}"

      if current_user.business.present? &&
         current_user.business.name.present? &&
         current_user.business.city.present? &&
         current_user.business.state.present? &&
         step != :onboard_complete
        return redirect_to dashboards_path
      end

      has_business = current_user.business.present?
      @business = has_business ? current_user.business : current_user.build_business
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
          current_user.create_business!(name: params[:business][:name])
          redirect_to_next(:onboard_company_location)
        end
      when :onboard_company_location
        if current_user.business.blank?
          flash[:alert] = 'Business name cannot be empty'
          redirect_to_next(:onboard_company_name)
        end
      else
        redirect_to dashboards_onboarding_path, alert: 'Something went wrong'
      end
    end

    def update
      case step
      when :onboard_company_name
        current_user.business.update(name: params[:business][:name])
        redirect_to_next(:onboard_company_location)
      when :onboard_company_location
        if current_user.business.blank?
          flash[:alert] = 'Business name cannot be empty'
          return redirect_to_next(:onboard_company_location)
        end

        if params[:business][:city].present? &&
           params[:business][:state].present? &&
           current_user.business.update(city: params[:business][:city], state: params[:business][:state])
          redirect_to_next(:onboard_complete)
        else
          flash[:alert] = 'State and city cannot be empty.'
          redirect_to_next(:onboard_company_location)
        end

      end
    end
  end
end
