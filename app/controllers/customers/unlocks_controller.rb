# frozen_string_literal: true

class Customers::UnlocksController < Devise::UnlocksController
  layout 'business/auth'

  def create
    if verify_recaptcha(action: 'unlock_account')
      super
    else
      self.resource = resource_class.new(query_params[:user])
      respond_with_navigational(resource) { render :new }
    end
  end

  private

  def query_params
    params.permit(:user)
  end
end
