# frozen_string_literal: true

class Customers::DashboardsController < ApplicationController
  include Pundit::Authorization

  before_action :authenticate_customer!
  layout 'customer/dashboard'

  def show; end
end
