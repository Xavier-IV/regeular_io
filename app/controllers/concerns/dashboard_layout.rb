# frozen_string_literal: true

module DashboardLayout
  extend ActiveSupport::Concern
  include Pundit::Authorization

  included do
    include Pundit::Authorization

    before_action :authenticate_client!
    layout 'business/dashboard'
  end

  protected

  def pundit_user
    current_client
  end
end
