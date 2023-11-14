# frozen_string_literal: true

require 'test_helper'

class Clients::Dashboards::BusinessesControllerTest < ActionDispatch::IntegrationTest
  test 'only authenticated' do
    get edit_clients_dashboards_business_url

    assert_response :redirect
    assert_redirected_to new_client_session_path
  end

  test 'render edit if no change' do
    sign_in clients(:client_business_new)
    patch clients_dashboards_business_url,
          params: {
            business: {
              state: 'Melaka',
              city: 'Alor Gajah'
            }
          }

    assert_response :redirect
    assert_redirected_to clients_dashboards_url
    follow_redirect!

    assert_select 'p', 'Record updated.'
  end

  test 'render edit if still pending_review' do
    client = clients(:client_business_new)
    client.business.update(status: 'pending_review')
    sign_in client

    patch clients_dashboards_business_url,
          params: {
            business: {
              state: 'Melaka',
              city: 'Alor Gajah'
            }
          }

    assert_response :redirect
    assert_redirected_to edit_clients_dashboards_business_url
    follow_redirect!

    assert_select 'p', 'Please wait for us to complete our review.'
  end

  test 'can upload valid logo' do
    client = clients(:client_business_new)
    sign_in client

    file_path = Rails.root.join('test/fixtures/files/placeholder_400_400.png').to_s
    logo = fixture_file_upload(file_path, 'image/png')

    patch clients_dashboards_business_url,
          params: {
            business: {
              logo:
            }
          }

    assert_response :redirect
    assert_redirected_to clients_dashboards_url
    follow_redirect!

    assert_select 'p', 'Record updated.'
    assert_equal client.business.logo.present? && client.business.logo.attached?, true
  end

  test 'can upload valid listing' do
    client = clients(:client_business_new)
    sign_in client

    file_path = Rails.root.join('test/fixtures/files/placeholder_400_400.png').to_s
    listing = fixture_file_upload(file_path, 'image/png')

    patch clients_dashboards_business_url,
          params: {
            business: {
              listing:
            }
          }

    assert_response :redirect
    assert_redirected_to clients_dashboards_url
    follow_redirect!

    assert_select 'p', 'Record updated.'
    assert_equal client.business.listing.present? && client.business.listing.attached?, true
  end

  test 'render edit if logo too large' do
    sign_in clients(:client_business_new)

    file_path = Rails.root.join('test/fixtures/files/large_image.png').to_s
    logo = fixture_file_upload(file_path, 'image/png')

    patch clients_dashboards_business_url,
          params: {
            business: {
              logo:
            }
          }

    assert_response :unprocessable_entity
    assert_select 'p', 'Image cannot be more than 5MB.'
  end

  test 'render edit if listing too large' do
    sign_in clients(:client_business_new)

    file_path = Rails.root.join('test/fixtures/files/large_image.png').to_s
    listing = fixture_file_upload(file_path, 'image/png')

    patch clients_dashboards_business_url,
          params: {
            business: {
              listing:
            }
          }

    assert_response :unprocessable_entity
    assert_select 'p', 'Image cannot be more than 5MB.'
  end

  test 'revert to new if approved before' do
    sign_in clients(:client_business_approved)

    patch clients_dashboards_business_url,
          params: {
            business: {
              name: 'New Name'
            }
          }

    assert_response :redirect
    assert_redirected_to clients_dashboards_path
    follow_redirect!

    assert_select 'p', 'Important information changed, kindly resubmit your application.'
  end
end
