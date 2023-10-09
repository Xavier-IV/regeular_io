# frozen_string_literal: true

require 'test_helper'

class Landings::FoodsControllerTest < ActionDispatch::IntegrationTest
  test 'should get index' do
    get food_root_url
    assert_response :success
  end
end
