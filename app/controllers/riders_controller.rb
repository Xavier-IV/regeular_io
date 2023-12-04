# frozen_string_literal: true

class RidersController < ApplicationController
  layout 'rider'
  def index
    @brands = Rider::Brand.all
  end
end
