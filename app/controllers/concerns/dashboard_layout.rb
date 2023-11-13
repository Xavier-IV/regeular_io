# frozen_string_literal: true

module DashboardLayout
  extend ActiveSupport::Concern

  included do
    layout 'business/dashboard'
  end
end
