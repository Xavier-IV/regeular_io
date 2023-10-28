# frozen_string_literal: true

class Customers::Dashboards::AccountsController < ApplicationController
  include Pundit::Authorization

  before_action :authenticate_customer!
  layout 'customer/dashboard'

  def show
    @user = current_customer
  end

  def edit
    @user = current_customer
  end

  def update
    @user = current_customer
    current_customer.avatar.attach(params[:customer][:avatar]) if params[:customer][:avatar]

    if current_customer.update_without_password(user_params)
      redirect_to customers_dashboards_account_path, notice: 'Record updated.'
    else
      render :show, status: :unprocessable_entity, alert: 'Unable to update.'
    end
  end

  private

  def user_params
    params.require(:customer).permit(:first_name, :last_name)
  end
end
