# frozen_string_literal: true

require 'test_helper'

class Customers::Dashboards::ReviewsControllerTest < ActionDispatch::IntegrationTest
  test 'should get index' do
    get customers_dashboards_reviews_index_url
    assert_response :success
  end
end
