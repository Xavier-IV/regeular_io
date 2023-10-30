# frozen_string_literal: true

require 'test_helper'

class Customers::Dashboards::RewardsControllerTest < ActionDispatch::IntegrationTest
  test 'should get show' do
    get customers_dashboards_rewards_show_url
    assert_response :success
  end
end
