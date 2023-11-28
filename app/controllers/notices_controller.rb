# frozen_string_literal: true

class NoticesController < ApplicationController
  def construction
    render plain: 'Under construction. Please check back later.', status: :service_unavailable
  end
end
