# frozen_string_literal: true

require 'test_helper'

class Clients::PaymentsControllerTest < ActionDispatch::IntegrationTest
  test 'should get new' do
    get clients_payments_new_url
    assert_response :success
  end
end
