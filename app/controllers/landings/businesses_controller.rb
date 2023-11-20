# frozen_string_literal: true

class Landings::BusinessesController < ApplicationController
  layout 'business'
  def index
    render layout: 'business_v2'
  end

  def pricing
    render layout: 'business_v2'
  end
end
