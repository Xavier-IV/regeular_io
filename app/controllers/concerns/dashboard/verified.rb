# frozen_string_literal: true

module Dashboard
  module Verified
    extend ActiveSupport::Concern

    included do
      before_action :account_verified!
    end

    protected

    def account_verified!
      if current_client.confirmed_at.blank?
        flash[:alert] = 'Your account is not approved yet.'
        return redirect_to clients_dashboards_path
      end

      if current_client.business.blank?
        flash[:alert] = 'You need to have a business.'
        return redirect_to clients_dashboards_path
      end

      return unless current_client.business.status != 'approved'

      flash[:alert] = 'We will first review your account.'
      redirect_to clients_dashboards_path
    end
  end
end
