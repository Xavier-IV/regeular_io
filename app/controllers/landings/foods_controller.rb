# frozen_string_literal: true

class Landings::FoodsController < ApplicationController
  def index
    @tags = [
      'Malay Cuisine', 'Chinese', 'Seafood', 'Arab',
      'Fast Food', '+20'
    ]
    @businesses = Business.listed
  end
end
