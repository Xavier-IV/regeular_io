# frozen_string_literal: true

require 'test_helper'

class Dashboards::QrsControllerTest < ActionDispatch::IntegrationTest
  test 'should get index' do
    get dashboards_qrs_url
    assert_response 302
  end
end
