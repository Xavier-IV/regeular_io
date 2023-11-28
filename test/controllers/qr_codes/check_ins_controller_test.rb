# frozen_string_literal: true

require 'test_helper'

class QrCodes::CheckInsControllerTest < ActionDispatch::IntegrationTest
  test 'should get new' do
    get new_qr_codes_check_in_url(reference: qr_code_check_ins(:check_in_one).id)
    assert_response :success
  end
end
