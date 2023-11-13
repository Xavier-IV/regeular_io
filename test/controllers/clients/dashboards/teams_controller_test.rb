# frozen_string_literal: true

require 'test_helper'

class Clients::Dashboards::TeamsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @client = clients(:client_one)
    @business = businesses(:one)
    @client.business_id = @business.id
    @client.save
  end

  test 'only authenticated' do
    get clients_dashboards_teams_url

    assert_response :redirect
    assert_redirected_to new_client_session_path
  end

  test 'should show onboarding process' do
    sign_in clients(:client_one)

    get clients_dashboards_teams_url

    assert_response :success
    assert_select 'p', /#{@client.email}/
    assert_select 'h2', 'Team Member (1/2)'
  end

  test 'should show onboarding process for 2 members' do
    sign_in clients(:client_one)
    @client2 = clients(:client_two)
    @client2.business_id = @business.id
    @client2.save

    get clients_dashboards_teams_url

    assert_response :success
    assert_select 'p', /#{@client.email}/
    assert_select 'p', /#{@client2.email}/
    assert_select 'h2', 'Team Member (2/2)'
  end
end
