# frozen_string_literal: true

class Dashboards::BusinessesController < ApplicationController
  include DashboardLayout

  before_action :prepare, :map_times, :map_progress, only: %i[edit update]

  def edit
    authorize @business
  end

  def update
    return render :edit if business_params.blank?

    if @business.status == 'pending_review'
      return redirect_to edit_dashboards_business_path, notice: 'Please wait for us to complete our review.'
    end

    if business_params.present? && asset_params[:logo] && asset_params[:logo].size > 5.megabytes
      flash.now[:alert] = 'Image cannot be more than 5MB.'
      return render :edit, status: :unprocessable_entity
    end
    if business_params.present? && asset_params[:listing] && asset_params[:listing].size > 5.megabytes
      flash.now[:alert] = 'Image cannot be more than 5MB.'
      return render :edit, status: :unprocessable_entity
    end

    @business.logo.attach(asset_params[:logo]) if business_params.present? && asset_params[:logo]
    @business.listing.attach(asset_params[:listing]) if business_params.present? && asset_params[:listing]

    if @business.update(business_params)
      observed_fields = %w[name address_line_1 address_line_2 postcode city state registration_id gmap_link]
      observed_changed = (@business.previous_changes &&
        observed_fields.select { |record| @business.previous_changes.include?(record) }.any?) ||
                         (asset_params[:logo].present? || asset_params[:listing].present?)

      if @business.status == 'approved' && observed_changed
        @business.status = 'new'
        @business.save

        @business.business_approval_histories.create(
          requested_by_id: current_client.id,
          status: @business.status,
          resolved: true,
          client_remark: params[:client_remark],
          system_remark: @business.previous_changes.to_s
        )
        return redirect_to dashboards_path, notice: 'Important information changed, kindly resubmit your application.'
      end

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

  def map_progress
    @progress = current_client.client_progresses.onboarded?([
                                                              'onboarding.get_started',
                                                              'onboarding.verified_email',
                                                              'onboarding.has_logo',
                                                              'onboarding.has_listing_image',
                                                              'onboarding.has_operating_hours',
                                                              'onboarding.has_gmap_link'
                                                            ])
  end

  def prepare
    @business = current_client.business
    @states = Common::Country.find_by(name: 'Malaysia').states
    @cities = @states.find_by(name: current_client.business.state).cities || []
    @approval = @business.business_approval_histories.unresolved.first
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
