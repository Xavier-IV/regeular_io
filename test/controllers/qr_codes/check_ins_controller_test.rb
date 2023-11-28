# frozen_string_literal: true

require 'test_helper'

class QrCodes::CheckInsControllerTest < ActionDispatch::IntegrationTest
  test 'should get new' do
    get qr_codes_check_ins_new_url
    assert_response :success
  end
end
