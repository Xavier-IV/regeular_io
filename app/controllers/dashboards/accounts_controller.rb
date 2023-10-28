# frozen_string_literal: true

class Dashboards::AccountsController < ApplicationController
  include DashboardLayout

  def show
    @user = current_client
  end

  def edit
    @user = current_client
  end

  def update
    current_client.avatar.attach(params[:client][:avatar]) if params[:client][:avatar]

    if current_client.update(user_params)
      redirect_to dashboards_account_path, notice: 'Record updated.'
    else
      render :show, status: :unprocessable_entity
    end
  end

  private

  def user_params
    params.require(:client).permit(:first_name, :last_name)
  end
end
