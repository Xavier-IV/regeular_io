# frozen_string_literal: true

require 'test_helper'

class Dashboards::Qrs::BanksControllerTest < ActionDispatch::IntegrationTest
  test 'should get show' do
    get dashboards_qrs_bank_url
    assert_response 302
  end
end
