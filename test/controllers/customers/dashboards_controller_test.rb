# frozen_string_literal: true

require 'test_helper'

class Customers::DashboardsControllerTest < ActionDispatch::IntegrationTest
  test 'should get show' do
    get customers_dashboard_url
    assert_response 302
  end
end
