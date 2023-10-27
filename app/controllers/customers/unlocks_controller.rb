# frozen_string_literal: true

class Customers::UnlocksController < Devise::UnlocksController
  layout 'business/auth'

  def create
    if verify_recaptcha(action: 'unlock_account')
      super
    else
      self.resource = resource_class.new(params[:user])
      respond_with_navigational(resource) { render :new }
    end
  end
end
