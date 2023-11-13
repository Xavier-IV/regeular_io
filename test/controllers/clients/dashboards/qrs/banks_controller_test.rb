# frozen_string_literal: true

require 'test_helper'

class Clients::Dashboards::Qrs::BanksControllerTest < ActionDispatch::IntegrationTest
  test 'should get show' do
    get clients_dashboards_qrs_bank_url
    assert_response 302
  end
end
