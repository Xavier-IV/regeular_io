# frozen_string_literal: true

class Admins::Dashboards::CopywritingsController < ApplicationController
  include AdminLayout

  def new; end

  def create
    redirect_to admins_dashboards_copywriting_path(id: params[:company_name])
  end

  def show; end

  def index; end
end
