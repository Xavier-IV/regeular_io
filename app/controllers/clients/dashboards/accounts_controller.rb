# frozen_string_literal: true

class Clients::Dashboards::AccountsController < ApplicationController
  include Dashboard::Layout
  include Dashboard::Auth

  def show
    @user = current_client
  end

  def edit
    @user = current_client
  end

  def update
    @user = current_client

    if asset_params[:avatar] && asset_params[:avatar].size > 5.megabytes
      flash.now[:alert] = 'Image cannot be more than 5MB.'
      return render :edit, status: :unprocessable_entity
    end

    current_client.avatar.attach(asset_params[:avatar]) if asset_params[:avatar]

    if current_client.update(user_params)
      redirect_to clients_dashboards_account_path, notice: 'Record updated.'
    else
      render :show, status: :unprocessable_entity
    end
  end

  private

  def user_params
    params.require(:client).permit(:first_name, :last_name)
  end

  def asset_params
    params.require(:client).permit(:avatar)
  end
end
