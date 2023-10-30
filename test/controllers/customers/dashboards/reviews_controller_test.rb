# frozen_string_literal: true

require 'test_helper'

class Customers::Dashboards::ReviewsControllerTest < ActionDispatch::IntegrationTest
  test 'should get index' do
    business = Business.first
    get customers_dashboards_reviews_url(business_id: business.id)
    assert_response 302
  end
end
