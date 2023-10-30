# frozen_string_literal: true

require 'test_helper'

class Dashboards::Rewards::DiscountsControllerTest < ActionDispatch::IntegrationTest
  test 'should get new' do
    get dashboards_rewards_discounts_new_url
    assert_response :success
  end

  test 'should get edit' do
    get dashboards_rewards_discounts_edit_url
    assert_response :success
  end

  test 'should get show' do
    get dashboards_rewards_discounts_show_url
    assert_response :success
  end
end
