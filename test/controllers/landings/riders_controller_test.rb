# frozen_string_literal: true

require 'test_helper'

class Landings::RidersControllerTest < ActionDispatch::IntegrationTest
  test 'should get index' do
    get rider_root_url
    assert_response :success
  end
end
