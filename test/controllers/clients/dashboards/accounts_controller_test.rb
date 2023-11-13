# frozen_string_literal: true

require 'test_helper'

class Clients::Dashboards::AccountsControllerTest < ActionDispatch::IntegrationTest
  test 'should get show' do
    get clients_dashboards_account_url
    assert_response 302
  end

  test 'should get edit' do
    get edit_clients_dashboards_account_url
    assert_response 302
  end
end
