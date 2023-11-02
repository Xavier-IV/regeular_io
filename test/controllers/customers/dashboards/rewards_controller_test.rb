# frozen_string_literal: true

require 'test_helper'

class Customers::Dashboards::RewardsControllerTest < ActionDispatch::IntegrationTest
  test 'should get show' do
    get customers_dashboards_reward_url(business_id: 1)
    assert_response 302
  end
end
