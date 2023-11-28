# frozen_string_literal: true

require 'test_helper'

class Clients::Dashboards::Rewards::BirthdaysControllerTest < ActionDispatch::IntegrationTest
  test 'only authenticated' do
    get clients_dashboards_reward_birthday_url

    assert_response :redirect
    assert_redirected_to new_client_session_path
  end

  test 'should get show' do
    sign_in clients(:client_business_approved)
    get clients_dashboards_reward_birthday_url
    assert_response :success
  end

  test 'should get new' do
    sign_in clients(:client_business_approved)
    get new_clients_dashboards_reward_birthday_url
    assert_response :success
  end

  test 'should redirect to new' do
    sign_in clients(:client_business_approved)

    get edit_clients_dashboards_reward_birthday_url
    assert_response :redirect
    assert_redirected_to new_clients_dashboards_reward_birthday_url
  end

  test 'should be able to edit' do
    client = clients(:client_business_approved)
    sign_in client

    Business::Reward.create(
      business_id: client.business.id,
      kind: 'Birthday',
      created_by: client,
      updated_by: client,
      value: 20,
      min_order_amount: 20.0,
      value_type: 'percentage',
      capped_amount: 5.0
    )

    get edit_clients_dashboards_reward_birthday_url
    assert_response :success
  end
end
