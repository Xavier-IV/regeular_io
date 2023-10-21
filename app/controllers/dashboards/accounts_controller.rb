# frozen_string_literal: true

class Dashboards::AccountsController < ApplicationController
  include DashboardLayout

  def show
    @user = current_user
  end

  def edit
    @user = current_user
  end

  def update
    current_user.avatar.attach(params[:user][:avatar]) if params[:user][:avatar]

    if current_user.update(user_params)
      redirect_to dashboards_account_path, notice: 'Record updated.'
    else
      render :show, status: :unprocessable_entity
    end
  end

  private

  def user_params
    params.require(:user).permit(:first_name, :last_name)
  end
end
