# frozen_string_literal: true

class Dashboards::TeamsController < ApplicationController
  include DashboardLayout

  def index
    @team = current_client.business.clients
  end
end
