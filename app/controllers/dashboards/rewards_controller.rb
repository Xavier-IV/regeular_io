# frozen_string_literal: true

class Dashboards::RewardsController < ApplicationController
  include DashboardLayout

  def show
    @discounts = Business::Reward.find_by(kind: 'Discount',
                                          business: current_client.business.id)
  end
end
