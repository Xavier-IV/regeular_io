# frozen_string_literal: true

require 'test_helper'

class Clients::Dashboards::ToolMarketings::CopywritingsControllerTest < ActionDispatch::IntegrationTest
  test 'should get show' do
    get clients_dashboards_tool_marketings_copywritings_show_url
    assert_response :success
  end
end
