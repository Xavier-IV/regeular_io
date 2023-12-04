# frozen_string_literal: true

class Riders::InvitationsController < Devise::InvitationsController
  layout 'rider/auth'
  add_flash_types :success

  def after_invite_path_for(_)
    rider_root_path
  end

  private

  # This is called when creating invitation.
  # It should return an instance of resource class.
  def invite_resource
    # skip sending emails on invite
    super do |user|
      user.role = 'rider'
    end
  end
end
