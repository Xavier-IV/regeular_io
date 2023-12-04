# frozen_string_literal: true

module Rider::Auth
  extend ActiveSupport::Concern
  include Pundit::Authorization

  included do
    include Pundit::Authorization

    before_action :authenticate_rider!

    protected

    def authenticate_rider!
      if rider_signed_in?
        super
      else
        redirect_to request.original_url, notice: 'Please sign in to continue'
      end
    end
  end

  def pundit_user
    current_rider
  end

  def account_verified
    current_rider.confirmed_at.present?
  end
end
