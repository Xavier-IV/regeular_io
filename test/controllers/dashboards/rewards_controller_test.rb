# frozen_string_literal: true

require 'test_helper'

class Dashboards::RewardsControllerTest < ActionDispatch::IntegrationTest
  test 'should get index' do
    get dashboards_reward_url
    assert_response 302
  end

  test 'should get show' do
    get dashboards_reward_url(1)
    assert_response 401
  end
end
