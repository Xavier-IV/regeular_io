# frozen_string_literal: true

require 'test_helper'

class Clients::Dashboards::ProgressesControllerTest < ActionDispatch::IntegrationTest
  test 'only authenticated' do
    post clients_dashboards_progress_url

    assert_response :redirect
    assert_redirected_to new_client_session_path
  end

  test 'create progress' do
    client = clients(:client_three)
    sign_in client
    post clients_dashboards_progress_url,
         params: { progress_type: 'onboarding.get_started' }

    assert_response :redirect
    assert_redirected_to clients_dashboards_path

    assert_equal client.client_progresses.first.progress_type, 'onboarding.get_started'
  end
end
