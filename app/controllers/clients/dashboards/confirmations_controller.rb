# frozen_string_literal: true

class Clients::Dashboards::ConfirmationsController < ApplicationController
  include Dashboard::Layout
  include Dashboard::Auth

  def new
    @sent_at = current_client.confirmation_sent_at
  end

  def create
    if current_client && !current_client.confirmed?
      current_client.send_confirmation_instructions
      current_client.confirmation_sent_at = Time.zone.now
      current_client.save

      flash[:success] = 'Confirmation instructions have been resent to your email address.'
      redirect_to clients_dashboards_path
    else
      flash[:alert] = 'Account already confirmed.'
    end
  end
end
