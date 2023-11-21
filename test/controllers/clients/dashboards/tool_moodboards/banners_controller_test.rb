# frozen_string_literal: true

require 'test_helper'

class Clients::Dashboards::ToolMoodboards::BannersControllerTest < ActionDispatch::IntegrationTest
  test 'should get new' do
    get clients_dashboards_tool_moodboards_banners_new_url
    assert_response :success
  end

  test 'should get show' do
    get clients_dashboards_tool_moodboards_banners_show_url
    assert_response :success
  end

  test 'should get index' do
    get clients_dashboards_tool_moodboards_banners_index_url
    assert_response :success
  end
end
