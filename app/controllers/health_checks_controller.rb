# frozen_string_literal: true

class HealthChecksController < ApplicationController
  def health
    render plain: 'OK', status: :ok
  end
end
