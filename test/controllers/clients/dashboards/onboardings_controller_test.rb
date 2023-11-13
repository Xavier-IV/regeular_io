# frozen_string_literal: true

require 'test_helper'

class Clients::Dashboards::OnboardingsControllerTest < ActionDispatch::IntegrationTest
  test 'only authenticated' do
    get clients_dashboards_onboarding_url

    assert_response :redirect
    assert_redirected_to new_client_session_path
  end

  test 'handles non onboarded' do
    sign_in clients(:client_one)
    get clients_dashboards_onboarding_url

    assert_response :redirect
    assert_redirected_to business_root_path
  end

  test 'handles first step' do
    sign_in clients(:client_one)
    get clients_dashboards_onboarding_url(id: 'onboard_company_name')

    assert_response :success
  end

  test 'handles second step' do
    sign_in clients(:client_one)
    post clients_dashboards_onboarding_url(id: 'onboard_company_name'),
         params: { business: { name: 'Company Name' } }

    assert_response :redirect
    assert_redirected_to clients_dashboards_onboarding_url(id: 'onboard_company_location')
  end

  test 'handles third step without company' do
    sign_in clients(:client_one)
    post clients_dashboards_onboarding_url(id: 'onboard_company_location'),
         params: { business: { state: 'Melaka', city: 'Alor Gajah' } }

    assert_response :redirect
    assert_redirected_to clients_dashboards_onboarding_url(id: 'onboard_company_name')
  end

  test 'handles third step with company' do
    client = clients(:client_business_basic)
    sign_in client

    patch clients_dashboards_onboarding_url(id: 'onboard_company_location'),
          params: { business: { state: 'Melaka', city: 'Alor Gajah' } }

    assert_response 302
    follow_redirect!
    assert_select 'h1', /Congratulations!/
  end
end
