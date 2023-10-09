# frozen_string_literal: true

require 'test_helper'

class QrCodesControllerTest < ActionDispatch::IntegrationTest
  test 'should get show' do
    get qr_code_url
    assert_response :success
  end
end
