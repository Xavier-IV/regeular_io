# frozen_string_literal: true

require 'test_helper'

class Clients::Dashboards::RewardsControllerTest < ActionDispatch::IntegrationTest
  test 'only authenticated' do
    get clients_dashboards_reward_url

    assert_response :redirect
    assert_redirected_to new_client_session_path
  end

  test 'should not get show' do
    sign_in clients(:client_three)

    get clients_dashboards_reward_url
    assert_response :redirect
  end

  test 'should get show' do
    sign_in clients(:client_business_approved)

    get clients_dashboards_reward_url
    assert_response :success
  end
end
