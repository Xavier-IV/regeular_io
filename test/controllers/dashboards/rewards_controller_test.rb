# frozen_string_literal: true

require 'test_helper'

class Dashboards::RewardsControllerTest < ActionDispatch::IntegrationTest
  test 'should get index' do
    get dashboards_rewards_url
    assert_response 302
  end

  test 'should get show' do
    get dashboards_reward_url(1)
    assert_response 302
  end

  test 'should get edit' do
    get edit_dashboards_reward_url(1)
    assert_response 302
  end
end
