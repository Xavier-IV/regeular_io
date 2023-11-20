# frozen_string_literal: true

require 'test_helper'

class Clients::Dashboards::ToolMarketings::DailyPostsControllerTest < ActionDispatch::IntegrationTest
  test 'should get index' do
    get clients_dashboards_tool_marketings_daily_posts_index_url
    assert_response :success
  end

  test 'should get new' do
    get clients_dashboards_tool_marketings_daily_posts_new_url
    assert_response :success
  end

  test 'should get show' do
    get clients_dashboards_tool_marketings_daily_posts_show_url
    assert_response :success
  end
end
