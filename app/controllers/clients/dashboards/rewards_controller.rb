# frozen_string_literal: true

class Clients::Dashboards::RewardsController < ApplicationController
  include DashboardLayout

  def show
    @discounts = Business::Reward.find_by(kind: 'Discount',
                                          business: current_client.business.id)
  end
end
