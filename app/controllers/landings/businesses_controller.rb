# frozen_string_literal: true

class Landings::BusinessesController < ApplicationController
  layout 'business'
  def index
    if client_signed_in? && current_client.business.blank?
      return redirect_to clients_dashboards_onboarding_path(id: :onboard_company_name)
    end

    if client_signed_in?
      @qr = current_client.business.qr_code_check_ins.find_by(scanned_times: 0)
      @qr = current_client.business.qr_code_check_ins.create if @qr.blank?
      @path = qr_code_url(reference: @qr.id)

      @customers = current_client.business.business_customers
    end
    @client_count = Client.all.count
    render layout: 'business_v2'
  end

  def printable
    return redirect_to business_root_path unless client_signed_in?

    @business = current_client.business
    @qr = current_client.business.qr_code_check_ins.find_by(scanned_times: 0)
    @qr = current_client.business.qr_code_check_ins.create if @qr.blank?
    @path = qr_code_url(reference: @qr.id)

    respond_to do |format|
      format.html
      format.pdf do
        render pdf: 'pdf_filename',
               layout: 'pdf',
               formats: [:html],
               disposition: :inline,
               background: true,
               print_media_type: true,
               no_background: false
      end
    end
  end

  def pricing
    render layout: 'business_v2'
  end

  def about
    render layout: 'business_v2'
  end
end
