# frozen_string_literal: true

require 'test_helper'

class Landings::Customers::ServicesControllerTest < ActionDispatch::IntegrationTest
  test 'should get index' do
    get landings_customers_services_index_url
    assert_response :success
  end

  test 'should get show' do
    get landings_customers_services_show_url
    assert_response :success
  end
end
