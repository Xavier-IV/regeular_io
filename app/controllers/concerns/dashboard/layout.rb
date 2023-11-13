# frozen_string_literal: true

module Dashboard
  module Layout
    extend ActiveSupport::Concern

    included do
      layout 'business/dashboard'
    end
  end
end
