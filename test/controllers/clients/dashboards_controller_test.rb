# frozen_string_literal: true

require 'test_helper'

class DashboardsControllerTest < ActionDispatch::IntegrationTest
  # test 'only authenticated' do
  #   get clients_dashboards_url
  #
  #   assert_response :redirect
  #   assert_redirected_to new_client_session_path
  # end
  #
  # test 'should show onboarding process' do
  #   sign_in clients(:client_one)
  #
  #   get clients_dashboards_url
  #
  #   assert_response :redirect
  #   assert_redirected_to clients_dashboards_onboarding_path(id: :onboard_company_name)
  # end
  #
  # test 'should get index if onboarded' do
  #   sign_in clients(:client_one)
  #
  #   client = clients(:client_one)
  #   business = businesses(:one)
  #   client.business_id = business.id
  #   client.save
  #
  #   get clients_dashboards_url
  #
  #   assert_response :success
  #   assert_select 'p', /AddressLine1/
  # end
end
