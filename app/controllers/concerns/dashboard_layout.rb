# frozen_string_literal: true

module DashboardLayout
  extend ActiveSupport::Concern

  included do
    include Pundit::Authorization

    before_action :authenticate_user!
    layout 'business/dashboard'
  end
end
