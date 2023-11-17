# frozen_string_literal: true

class Clients::Dashboards::RewardsController < ApplicationController
  include Dashboard::Layout
  include Dashboard::Auth
  include Dashboard::Verified

  def show
    @discounts = Business::Reward.find_by(kind: 'Discount',
                                          business: current_client.business.id)
  end
end
