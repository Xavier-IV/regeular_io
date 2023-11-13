require "test_helper"

class Admins::Dashboards::TeamsControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get admins_dashboards_teams_index_url
    assert_response :success
  end
end
