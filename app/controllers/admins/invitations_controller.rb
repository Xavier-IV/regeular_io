# frozen_string_literal: true

class Admins::InvitationsController < Devise::InvitationsController
  before_action :authenticate_admin!, only: %i[new create destroy]

  layout 'admin/auth'
  add_flash_types :success

  def after_invite_path_for(_)
    admins_dashboards_teams_path
  end

  private

  # This is called when creating invitation.
  # It should return an instance of resource class.
  def invite_resource
    # skip sending emails on invite
    super do |user|
      user.role = 'member'
    end
  end
end
