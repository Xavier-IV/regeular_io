# frozen_string_literal: true

require 'test_helper'

class Clients::Dashboards::ToolMoodboardsControllerTest < ActionDispatch::IntegrationTest
  test 'should get show' do
    get clients_dashboards_tool_moodboards_show_url
    assert_response :success
  end
end
