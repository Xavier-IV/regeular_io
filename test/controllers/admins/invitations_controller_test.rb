# frozen_string_literal: true

require 'test_helper'

class Admins::InvitationsControllerTest < ActionDispatch::IntegrationTest
  test 'must authenticate' do
    get admins_dashboard_url

    assert_response 302
    assert_redirected_to admin_session_path
  end

  test 'should show form' do
    sign_in admins(:admin_one)
    get admins_dashboards_teams_url

    assert_response 200
  end

  test 'send invitation' do
    sign_in admins(:admin_one)
    get new_admin_invitation_url

    post admin_invitation_url,
         params: { admin: { email: 'newadmin@test.com' } }

    assert_response :redirect
    assert_redirected_to admins_dashboards_teams_url
    follow_redirect!

    admin = Admin.find_by(email: 'newadmin@test.com')

    assert_equal admin.role, 'member'
    assert_select 'p', 'An invitation email has been sent to newadmin@test.com.'
  end
end
