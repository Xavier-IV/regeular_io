# frozen_string_literal: true

module Users
  class RegistrationsController < Devise::RegistrationsController
    layout 'business/auth'
    add_flash_types :success

    def create
      if verify_recaptcha(action: 'register')
        super
      else
        self.resource = resource_class.new(sign_up_params)
        respond_with_navigational(resource) { render :new }
      end
    end
  end
end
