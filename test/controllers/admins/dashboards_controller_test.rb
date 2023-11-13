# frozen_string_literal: true

require 'test_helper'

class Admins::DashboardsControllerTest < ActionDispatch::IntegrationTest
  include Devise::Test::IntegrationHelpers # Include Devise test helpers

  test 'should get index' do
    sign_in admins(:admin_one)

    get admins_dashboard_url
    assert_response 200
  end
end
