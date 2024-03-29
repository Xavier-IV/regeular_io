# frozen_string_literal: true

module Dashboard
  module Auth
    extend ActiveSupport::Concern
    include Pundit::Authorization

    included do
      include Pundit::Authorization

      before_action :authenticate_client!
    end

    protected

    def pundit_user
      current_client
    end

    def account_verified
      current_client.confirmed_at.present?
    end
  end
end
