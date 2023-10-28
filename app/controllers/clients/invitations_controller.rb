# frozen_string_literal: true

class Clients::InvitationsController < Devise::InvitationsController
  before_action :authenticate_client!, only: %i[new create destroy]

  layout 'business/auth'
  add_flash_types :success

  def after_invite_path_for(_)
    dashboards_teams_path
  end

  private

  # This is called when creating invitation.
  # It should return an instance of resource class.
  def invite_resource
    # skip sending emails on invite
    super do |user|
      user.role = 'member'
      user.business_id = current_client.business.id
    end
  end
end
