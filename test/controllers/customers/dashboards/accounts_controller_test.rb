# frozen_string_literal: true

require 'test_helper'

class Customers::Dashboards::AccountsControllerTest < ActionDispatch::IntegrationTest
  test 'should get show' do
    get customers_dashboards_account_url
    assert_response 302
  end
end
