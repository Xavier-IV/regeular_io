# frozen_string_literal: true

require 'test_helper'

class Landings::CustomersControllerTest < ActionDispatch::IntegrationTest
  test 'should get index' do
    get customer_root_url
    assert_response :success
  end

  test 'upgrade level' do
    get how_it_works_url
    assert_response :success
    assert_select 'p', '5 more reviews to next level'

    4.times do |experience|
      post how_it_works_url,
           params: {
             review: {
               experience:,
               level: 0,
               rating: 5
             }
           }
      assert_response :found
      follow_redirect!
      assert_select 'p', "#{4 - experience} more reviews to next level"
    end
  end
end
