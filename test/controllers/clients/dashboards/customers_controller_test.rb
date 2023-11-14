# frozen_string_literal: true

require 'test_helper'

class Clients::Dashboards::CustomersControllerTest < ActionDispatch::IntegrationTest
  test 'only authenticated' do
    get clients_dashboards_customers_url

    assert_response :redirect
    assert_redirected_to new_client_session_path
  end

  test 'should get blank index' do
    sign_in clients(:client_business_new)
    get clients_dashboards_customers_url

    assert_response :success
    assert_select 'p', 'There\'s no regular customer reviews yet.'
    assert_select 'p', 'There\'s no anonymous reviews yet.'
  end

  test 'should see listed reviews' do
    sign_in clients(:client_three)
    get clients_dashboards_customers_url

    assert_response :success
    assert_select 'p', 'There\'s no regular customer reviews yet.'
    assert_select 'p', { count: 0, text: 'There\'s no anonymous reviews yet.' }
  end
end
