# frozen_string_literal: true

require 'test_helper'

class AuthClientFlowsTest < ActionDispatch::IntegrationTest
  setup do
    get new_client_registration_url
    assert_select 'h2', 'Sign up'

    post client_registration_path,
         params: { client: { email: 'user@company.com', password: '123456', password_confirmation: '123456' } }
    assert_response :redirect
    follow_redirect!
  end

  teardown do
    Rails.cache.clear
  end

  test 'can see the business page' do
    get business_root_url
    assert_select 'h1', 'Regülar for business'
  end

  test 'can sign in' do
    delete destroy_client_session_path

    get new_client_session_path
    assert_select 'h2', 'Log in'

    post client_session_path,
         params: { client: { email: 'user@company.com', password: '123456' } }
    assert_response :redirect
  end

  test 'redirect to onboarding if no business' do
    get clients_dashboards_path
    assert_response :redirect
    follow_redirect!

    assert_select 'h1', 'Welcome Onboard!'
  end

  test 'redirect to dashboard if has business' do
    client = Client.find_by(email: 'user@company.com')
    client.create_business(
      name: 'User Company',
      state: 'Melaka',
      city: 'Alor Gajah'
    )
    client.save

    get clients_dashboards_path
    assert_response :success

    assert_select 'h1', 'User Company'
  end

  test 'can sign up and onboard' do
    assert_response :redirect

    get clients_dashboards_path
    assert_response :redirect
    follow_redirect!

    assert_select 'h1', 'Welcome Onboard!'
    assert_select 'p', 'Let’s start by adding your business informations!'

    post clients_dashboards_onboarding_path(id: 'onboard_company_name'),
         params: { business: { name: 'Test' }, id: 'onboard_company_name' }
    assert_response :redirect
    follow_redirect!

    assert_select 'h1', 'Business Location'

    patch clients_dashboards_onboarding_path(id: 'onboard_company_location'),
          params: { business: { state: 'Melaka', city: 'Alor Gajah' }, id: 'onboard_company_location' }
    assert_response :redirect
    follow_redirect!

    assert_select 'h1', 'Congratulations! 🎉'
    assert_select 'p', 'Let\'s see your dashboard.'

    get clients_dashboards_path
    assert_response :success
    assert_select 'p', 'Ready to get listed? Let\'s get started!'
  end
end
