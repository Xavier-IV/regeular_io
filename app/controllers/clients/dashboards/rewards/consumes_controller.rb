# frozen_string_literal: true

class Clients::Dashboards::Rewards::ConsumesController < ApplicationController
  include Dashboard::Layout
  include Dashboard::Auth

  def edit
    @qr = QrCode::Reward.find(query_params[:reference])
    @customer_reward = @qr.customer_reward
  end

  def update
    @customer_reward = current_client.business.customer_rewards.find(reward_params[:id])
    @customer_reward.claimed_at = Time.zone.now
    @qr = @customer_reward.qr_code_reward

    if @customer_reward.save
      flash[:success] = 'Successfully applied!'
      redirect_to dashboards_reward_consume_path(id: @customer_reward.id)
    else
      flash.now[:alert] = @customer_reward.errors.full_messages.join('. ')
      render :edit, status: :unprocessable_entity
    end
  end

  def show
    @customer_reward = current_client.business.customer_rewards.find(query_params[:id])
  end

  private

  def query_params
    params.permit(:reference)
  end

  def reward_params
    params.require(:customer_reward).permit(:id)
  end
end
