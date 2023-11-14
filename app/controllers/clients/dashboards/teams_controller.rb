# frozen_string_literal: true

class Clients::Dashboards::TeamsController < ApplicationController
  include Dashboard::Layout
  include Dashboard::Auth

  def index
    @team = current_client.business.clients
  end
end
