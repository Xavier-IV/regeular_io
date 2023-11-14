# frozen_string_literal: true

require 'test_helper'

class Clients::Dashboards::ConfirmationsControllerTest < ActionDispatch::IntegrationTest
  test 'only authenticated' do
    get new_clients_dashboards_confirmation_url

    assert_response :redirect
    assert_redirected_to new_client_session_path
  end

  test 'should get new' do
    client = clients(:client_one)
    client.confirmed_at = nil
    client.confirmation_sent_at = Time.zone.now - 5.minutes
    client.save
    sign_in client

    get new_clients_dashboards_confirmation_url

    assert_response :success
    assert_select 'h2', 'Resend confirmation instructions?'
  end

  test 'should block get new' do
    sign_in clients(:client_one)
    get new_clients_dashboards_confirmation_url

    assert_response :success
    assert_select 'h2', { count: 0, text: 'Resend confirmation instructions?' }
    assert_select 'p', 'Please wait 2 minutes before sending again.'
  end

  test 'only authenticated post' do
    post clients_dashboards_confirmation_url

    assert_response :redirect
    assert_redirected_to new_client_session_path
  end

  test 'should block confirmed account' do
    client = clients(:client_one)
    client.confirmed_at = Time.zone.now
    client.confirmation_sent_at = Time.zone.now - 1.minute
    client.save
    sign_in client
    post clients_dashboards_confirmation_url

    assert_response :redirect
    assert_redirected_to new_clients_dashboards_confirmation_url
    follow_redirect!

    assert_select 'p', 'Account already confirmed.'
  end

  test 'should allow unconfirmed account' do
    client = clients(:client_business_new)
    client.confirmed_at = nil
    client.confirmation_sent_at = Time.zone.now - 10.minutes
    client.save
    sign_in client
    post clients_dashboards_confirmation_url

    assert_response :redirect
    assert_redirected_to clients_dashboards_path

    follow_redirect!

    assert_select 'p', 'Confirmation instructions have been resent to your email address.'
  end
end
