# frozen_string_literal: true

class Dashboards::BusinessesController < ApplicationController
  include DashboardLayout

  before_action :map_times, only: %i[edit update]

  def edit
    @business = current_client.business
    authorize @business
    @states = Common::Country.find_by(name: 'Malaysia').states
    @cities = @states.find_by(name: current_client.business.state).cities || []
  end

  def update
    @business = current_client.business
    @states = Common::Country.find_by(name: 'Malaysia').states
    @cities = @states.find_by(name: current_client.business.state).cities || []

    return render :edit if business_params.blank?

    @business.logo.attach(asset_params[:logo]) if business_params.present? && asset_params[:logo]
    @business.listing.attach(asset_params[:listing]) if business_params.present? && asset_params[:listing]

    if @business.update(business_params)
      redirect_to dashboards_path, notice: 'Record updated.'
    else
      flash[:alert] = @business.errors.full_messages.join('. ')
      render :edit, status: :unprocessable_entity
    end
  end

  private

  def business_params
    params.require(:business).permit(:address_line_1, :address_line_2, :postcode, :city, :state,
                                     :registration_id, :gmap_link,
                                     :open_at, :close_at,
                                     :name, :logo, :listing)
  end

  def asset_params
    params.require(:business).permit(:logo, :listing)
  end

  def map_times
    start_time = DateTime.new(2000, 1, 1, 0, 0)
    end_time = DateTime.new(2000, 1, 1, 23, 30)
    interval = 30.minutes

    hours_list = []

    current_time = start_time
    while current_time <= end_time
      hours_list << [current_time.strftime('%H:%M'), current_time.to_time]
      current_time += interval
    end

    @hours = hours_list
  end
end
