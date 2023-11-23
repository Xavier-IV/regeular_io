# frozen_string_literal: true

require 'test_helper'

class Clients::Dashboards::ToolMarketings::EngagementsControllerTest < ActionDispatch::IntegrationTest
  test 'should get index' do
    get clients_dashboards_tool_marketings_engagements_index_url
    assert_response :success
  end

  test 'should get new' do
    get clients_dashboards_tool_marketings_engagements_new_url
    assert_response :success
  end
end
