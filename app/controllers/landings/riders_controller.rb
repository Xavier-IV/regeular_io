# frozen_string_literal: true

class Landings::RidersController < ApplicationController
  layout 'rider'

  def index
    @brands = Rider::Brand.all
  end
end
