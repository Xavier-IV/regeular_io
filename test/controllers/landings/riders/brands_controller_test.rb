# frozen_string_literal: true

require 'test_helper'

class Landings::Riders::BrandsControllerTest < ActionDispatch::IntegrationTest
  test 'should get show' do
    get rider_brand_url(slug: 'brand1')
    assert_response :success
  end
end
