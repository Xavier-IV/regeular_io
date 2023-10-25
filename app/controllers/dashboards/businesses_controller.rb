# frozen_string_literal: true

class Dashboards::BusinessesController < ApplicationController
  include DashboardLayout

  def edit
    @business = current_client.business
    @states = Common::Country.find_by(name: 'Malaysia').states
    @cities = @states.find_by(name: current_client.business.state).cities || []
  end

  def update
    @business = current_client.business
    @states = Common::Country.find_by(name: 'Malaysia').states
    @cities = @states.find_by(name: current_client.business.state).cities || []

    return render :edit if params[:business].blank?

    @business.logo.attach(params[:business][:logo]) if params[:business] && params[:business][:logo]
    @business.listing.attach(params[:business][:listing]) if params[:business] && params[:business][:listing]

    if @business.update(business_params)
      redirect_to dashboards_path, notice: 'Record updated.'
    else
      flash[:alert] = @business.errors.full_messages.join('. ')
      render :edit, status: :unprocessable_entity
    end
  end

  private

  def business_params
    params.require(:business).permit(:address_line_1, :address_line_2, :postcode, :city, :state, :registration_id,
                                     :name)
  end
end
