# frozen_string_literal: true

require 'test_helper'

class Admins::Dashboards::TeamsControllerTest < ActionDispatch::IntegrationTest
  test 'should get index' do
    get admins_dashboards_teams_url
    assert_response :redirect
  end
end
