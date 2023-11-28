# frozen_string_literal: true

class Clients::Dashboards::Rewards::BirthdaysController < ApplicationController
  include Dashboard::LayoutDetail
  include Dashboard::Auth
  include Dashboard::Verified

  def new
    @reward = Business::Reward.new(kind: 'Birthday')
  end

  def create
    @reward = Business::Reward.new(rewards_param)
    @reward.business = current_client.business
    @reward.created_by = current_client
    @reward.updated_by = current_client
    @reward.kind = 'Birthday'
    @reward.is_active = rewards_param[:toggle] == '1'

    if @reward.save
      flash[:notice] = 'Reward created.'
      redirect_to new_clients_dashboards_reward_birthday_path
    else
      flash.now[:alert] = @reward.errors.full_messages.join('. ')
      render :new, status: :unprocessable_entity
    end
  end

  def edit
    @reward = Business::Reward.find_by(kind: 'Birthday',
                                       business: current_client.business.id)

    redirect_to new_clients_dashboards_reward_birthday_path if @reward.blank?
  end

  def update
    Rails.logger.debug params
    @reward = Business::Reward.find_by(kind: 'Birthday',
                                       business: current_client.business.id)
    @reward.assign_attributes(rewards_param.except(:kind))
    @reward.updated_by = current_client
    @reward.business = current_client.business
    @reward.is_active = params[:business_reward][:toggle] == '1'

    if @reward.save
      flash[:notice] = 'Reward updated.'
      redirect_to clients_dashboards_reward_path
    else
      flash.now[:alert] = @reward.errors.full_messages.join(', ')
      render :edit, status: :unprocessable_entity
    end
  end

  private

  def rewards_param
    params.require(:business_reward).permit(:kind, :value, :value_type, :capped_amount, :min_order_amount)
  end
end
