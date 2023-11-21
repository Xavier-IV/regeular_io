require "test_helper"

class Clients::Dashboards::ToolMoodboards::InteriorDesignsControllerTest < ActionDispatch::IntegrationTest
  test "should get new" do
    get clients_dashboards_tool_moodboards_interior_designs_new_url
    assert_response :success
  end

  test "should get index" do
    get clients_dashboards_tool_moodboards_interior_designs_index_url
    assert_response :success
  end
end
