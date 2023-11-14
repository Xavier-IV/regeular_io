# frozen_string_literal: true

require 'test_helper'

class Admins::Dashboards::ApprovalsControllerTest < ActionDispatch::IntegrationTest
  include Devise::Test::IntegrationHelpers # Include Devise test helpers

  setup do
    sign_in admins(:admin_one)
  end

  test 'only authenticated' do
    delete destroy_admin_session_url

    business = businesses(:one)
    post admins_dashboards_approval_approve_path(business_id: business.id)
    assert_response 302
    assert_redirected_to admin_session_path
    follow_redirect!

    assert_select 'p', 'You need to sign in or sign up before continuing.'

    post admins_dashboards_approval_reject_path(business_id: business.id)
    assert_response 302
    assert_redirected_to admin_session_path
    follow_redirect!

    assert_select 'p', 'You need to sign in or sign up before continuing.'
  end

  test 'approving listing' do
    business = businesses(:one)

    get admins_dashboard_url
    assert_response 200

    post admins_dashboards_approval_approve_path(business_id: business.id)
    assert_response 302
    assert_redirected_to admins_dashboard_path
    follow_redirect!

    assert_select 'p', 'Business approved.'
  end

  test 'rejecting listing' do
    business = businesses(:two)

    get admins_dashboard_url
    assert_response 200

    post admins_dashboards_approval_reject_path(business_id: business.id),
         params: { system_remark: 'Your application has been rejected.' }
    assert_response 302
    assert_redirected_to admins_dashboard_path
    follow_redirect!

    assert_select 'p', 'Business rejected.'

    history = business.business_approval_histories.find_by(resolved: false)

    assert_equal Business.find(business.id).status, 'rejected'
    assert_equal history.status, 'rejected'
  end

  test 'rejecting listing without remark' do
    business = businesses(:two)

    get admins_dashboard_url
    assert_response 200

    post admins_dashboards_approval_reject_path(business_id: business.id)
    assert_response 302
    assert_redirected_to admins_dashboard_path
    follow_redirect!

    business = businesses(:two)
    assert_select 'p', 'Remark cannot be empty when rejecting.'
    assert_equal business.status, 'new'
  end
end
