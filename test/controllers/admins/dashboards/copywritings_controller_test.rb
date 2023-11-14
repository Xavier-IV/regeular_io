# frozen_string_literal: true

require 'test_helper'

class Admins::Dashboards::CopywritingsControllerTest < ActionDispatch::IntegrationTest
  test 'should get index' do
    get admins_dashboards_copywritings_url
    assert_response :redirect
    assert_redirected_to admin_session_path
  end
end
