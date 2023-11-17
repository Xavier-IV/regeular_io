# frozen_string_literal: true

require 'test_helper'

class Clients::Dashboards::QrsControllerTest < ActionDispatch::IntegrationTest
  test 'only authenticated' do
    get clients_dashboards_qrs_url

    assert_response :redirect
    assert_redirected_to new_client_session_path
  end

  test 'should not get index' do
    sign_in clients(:client_three)
    get clients_dashboards_qrs_url

    assert_response :redirect
  end

  test 'should get index' do
    sign_in clients(:client_business_approved)
    get clients_dashboards_qrs_url

    assert_response :success
  end
end
