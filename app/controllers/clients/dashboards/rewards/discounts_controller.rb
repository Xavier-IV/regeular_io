# frozen_string_literal: true

class Clients::Dashboards::Rewards::DiscountsController < ApplicationController
  include Dashboard::Layout
  include Dashboard::Auth

  def new
    @reward = Business::Reward.new(kind: 'Discount')
  end

  def create
    @reward = Business::Reward.new(rewards_param)
    @reward.business = current_client.business
    @reward.created_by = current_client
    @reward.updated_by = current_client

    if @reward.save
      flash[:notice] = 'Reward created.'
      redirect_to clients_dashboards_reward_path
    else
      flash.now[:alert] = @reward.errors.full_messages.join('. ')
      render :new, status: :unprocessable_entity
    end
  end

  def show
    redirect_to edit_clients_dashboards_reward_discount_path
  end

  def edit
    @reward = Business::Reward.find_by(kind: 'Discount',
                                       business: current_client.business.id)

    redirect_to new_clients_dashboards_reward_discount_path if @reward.blank?
  end

  def update
    @reward = Business::Reward.find_by(kind: 'Discount',
                                       business: current_client.business.id)
    @reward.updated_by = current_client

    if @reward.update(rewards_param.except(:kind))
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
