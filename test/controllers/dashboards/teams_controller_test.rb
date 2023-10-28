# frozen_string_literal: true

require 'test_helper'

class Dashboards::TeamsControllerTest < ActionDispatch::IntegrationTest
  test 'should get index' do
    get dashboards_teams_index_url
    assert_response :success
  end
end
