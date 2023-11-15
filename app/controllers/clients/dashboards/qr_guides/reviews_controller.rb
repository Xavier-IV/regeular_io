# frozen_string_literal: true

class Clients::Dashboards::QrGuides::ReviewsController < ApplicationController
  include Dashboard::Layout
  include Dashboard::Auth

  def show
    render layout: 'business/dashboard_detail'
  end
end