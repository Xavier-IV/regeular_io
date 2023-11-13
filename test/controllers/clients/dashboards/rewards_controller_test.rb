# frozen_string_literal: true

require 'test_helper'

class Clients::Dashboards::RewardsControllerTest < ActionDispatch::IntegrationTest
  test 'should get show' do
    sign_in clients(:client_three)

    get clients_dashboards_reward_url
    assert_response :success
  end
end
