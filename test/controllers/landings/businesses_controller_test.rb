# frozen_string_literal: true

require 'test_helper'

class Landings::BusinessesControllerTest < ActionDispatch::IntegrationTest
  test 'should get index' do
    get business_root_url
    assert_response :success
  end
end
