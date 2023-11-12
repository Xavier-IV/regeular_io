# frozen_string_literal: true

require 'test_helper'

class AuthCustomerFlowsTest < ActionDispatch::IntegrationTest

  setup do
    get new_customer_registration_url
    assert_select 'h2', 'Sign up'

    post customer_registration_path,
         params: { customer: { email: 'user@company.com', password: '123456', password_confirmation: '123456' } }
    assert_response :redirect

    assert_redirected_to customer_root_path
  end

  teardown do
    Rails.cache.clear
  end

  test 'can see the listing page' do
    get root_url
    assert_response :redirect
    assert_redirected_to customer_root_path(most: 'regular')

    follow_redirect!

    assert_select 'h1', 'Regülar'
  end

  test 'can sign in' do
    delete destroy_customer_session_path

    get new_customer_session_path
    assert_select 'h2', 'Log in'

    post customer_session_path,
         params: { customer: { email: 'user@company.com', password: '123456' } }
    assert_response :redirect
    assert_redirected_to root_path
  end

  test 'retain redirect after sign in' do
    delete destroy_customer_session_path
    assert_response :redirect
    assert_redirected_to root_path

    get dashboards_customers_url
    assert_response :redirect
    follow_redirect!
    assert_select 'h2', 'Log in'

    post customer_session_url,
         params: { customer: { email: 'user@company.com', password: '123456' } }
    assert_response :redirect
    follow_redirect!

    assert_redirected_to customer_root_url(most: 'regular')
  end
end
