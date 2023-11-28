# frozen_string_literal: true

class Clients::Dashboards::Qrs::CheckInsController < ApplicationController
  include Dashboard::Layout
  include Dashboard::Auth
  include Dashboard::Verified

  def show
    @qr = current_client.business.qr_code_check_ins.find_by(scanned_times: 0)
    @qr = current_client.business.qr_code_check_ins.create if @qr.blank?
    @path = qr_code_url(reference: @qr.id)
  end
end
