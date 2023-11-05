# frozen_string_literal: true

class ErrorsController < ApplicationController
  def not_found
    respond_to do |format|
      format.html { render status: :not_found }
      format.json { render json: { error: 'Not Found' }, status: :not_found }
      format.all { head :not_found }
    end
  end

  def internal_server_error
    respond_to do |format|
      format.html { render status: :internal_server_error }
      format.json { render json: { error: 'Internal Server Error' }, status: :internal_server_error }
      format.all { head :internal_server_error }
    end
  end
end
