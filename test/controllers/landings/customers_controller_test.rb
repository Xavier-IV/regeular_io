# frozen_string_literal: true

require 'test_helper'

class Landings::CustomersControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get customer_root_url
    assert_response :success
  end
end
