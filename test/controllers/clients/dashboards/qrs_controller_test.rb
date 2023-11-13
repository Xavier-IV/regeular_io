# frozen_string_literal: true

require 'test_helper'

class Clients::Dashboards::QrsControllerTest < ActionDispatch::IntegrationTest
  test 'should get index' do
    get clients_dashboards_qrs_url
    assert_response 302
  end
end
