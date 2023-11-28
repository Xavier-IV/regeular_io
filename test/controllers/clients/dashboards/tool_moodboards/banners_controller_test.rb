# frozen_string_literal: true

require 'test_helper'

class Clients::Dashboards::ToolMoodboards::BannersControllerTest < ActionDispatch::IntegrationTest
  test 'only authenticated' do
    get new_clients_dashboards_tool_moodboards_banner_url

    assert_response :redirect
    assert_redirected_to new_client_session_path
  end

  test 'should get new' do
    sign_in clients(:client_business_approved)

    get new_clients_dashboards_tool_moodboards_banner_url
    assert_response :success
  end

  test 'should get show' do
    sign_in clients(:client_business_approved)

    get clients_dashboards_tool_moodboards_banner_url(id: 1)
    assert_response :success
  end

  test 'should get index' do
    sign_in clients(:client_business_approved)

    get clients_dashboards_tool_moodboards_banners_url
    assert_response :success
  end
end
