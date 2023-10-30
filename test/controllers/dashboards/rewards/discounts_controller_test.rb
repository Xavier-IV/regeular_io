# frozen_string_literal: true

require 'test_helper'

class Dashboards::Rewards::DiscountsControllerTest < ActionDispatch::IntegrationTest
  test 'should get new' do
    get new_dashboards_reward_discount_url
    assert_response 302
  end

  test 'should get edit' do
    get edit_dashboards_reward_discount_url
    assert_response 302
  end

  test 'should get show' do
    get dashboards_reward_discount_url
    assert_response 302
  end
end
