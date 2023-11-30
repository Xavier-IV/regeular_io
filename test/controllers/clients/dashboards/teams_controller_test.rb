# frozen_string_literal: true

require 'test_helper'

class Clients::Dashboards::TeamsControllerTest < ActionDispatch::IntegrationTest
  # setup do
  #   @client = clients(:client_one)
  #   @business = businesses(:one)
  #   @client.business_id = @business.id
  #   @client.save
  # end
  #
  # test 'only authenticated' do
  #   get clients_dashboards_teams_url
  #
  #   assert_response :redirect
  #   assert_redirected_to new_client_session_path
  # end
  #
  # test 'should show team member' do
  #   client = clients(:client_business_approved)
  #   sign_in client
  #
  #   get clients_dashboards_teams_url
  #
  #   assert_response :success
  #   assert_select 'p', /#{client.email}/
  #   assert_select 'h2', 'Team Member (1/2)'
  # end
  #
  # test 'should not show teams' do
  #   sign_in clients(:client_one)
  #   @client2 = clients(:client_two)
  #   @client2.business_id = @business.id
  #   @client2.save
  #
  #   get clients_dashboards_teams_url
  #
  #   assert_response :redirect
  # end
  #
  # test 'should show team for 2 members' do
  #   client = clients(:client_business_approved)
  #   sign_in client
  #   @client2 = clients(:client_two)
  #   @client2.business_id = client.business.id
  #   @client2.save
  #
  #   get clients_dashboards_teams_url
  #
  #   assert_response :success
  #   assert_select 'h2', 'Team Member (2/2)'
  #   assert_select 'p', /#{client.email}/
  #   assert_select 'p', /#{@client2.email}/
  # end
end
