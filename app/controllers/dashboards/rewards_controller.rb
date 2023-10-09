# frozen_string_literal: true

class Dashboards::RewardsController < ApplicationController
  include Pundit::Authorization

  before_action :authenticate_user!
  layout 'business/dashboard'

  def index; end

  def show; end

  def edit; end
end
