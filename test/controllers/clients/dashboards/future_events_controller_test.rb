require "test_helper"

class Clients::Dashboards::FutureEventsControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get clients_dashboards_future_events_index_url
    assert_response :success
  end

  test "should get show" do
    get clients_dashboards_future_events_show_url
    assert_response :success
  end
end
