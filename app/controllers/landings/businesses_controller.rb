# frozen_string_literal: true

class Landings::BusinessesController < ApplicationController
  layout 'business'
  def index
    if client_signed_in?
      @qr = current_client.business.qr_code_check_ins.find_by(scanned_times: 0)
      @qr = current_client.business.qr_code_check_ins.create if @qr.blank?
      @path = qr_code_url(reference: @qr.id)

      @customers = current_client.business.business_customers
    end
    @client_count = Client.all.count
    render layout: 'business_v2'
  end

  def pricing
    render layout: 'business_v2'
  end

  def about
    render layout: 'business_v2'
  end
end
