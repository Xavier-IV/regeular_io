# frozen_string_literal: true

module Dashboard
  module LayoutDetail
    extend ActiveSupport::Concern

    included do
      layout 'business/dashboard_detail'
    end
  end
end
