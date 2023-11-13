# frozen_string_literal: true

require 'test_helper'

class Clients::Dashboards::Rewards::ConsumesControllerTest < ActionDispatch::IntegrationTest
  test 'should get new' do
    get new_clients_dashboards_reward_consume_url
    assert_response 302
  end

  test 'should get show' do
    get clients_dashboards_reward_consume_url
    assert_response 302
  end
end
