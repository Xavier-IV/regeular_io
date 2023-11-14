# frozen_string_literal: true

class Clients::InvitationsController < Devise::InvitationsController
  before_action :authenticate_client!, only: %i[new create destroy]

  layout 'business/auth'
  add_flash_types :success

  def new
    @team_count = current_client.business.clients.count
    super
  end

  def create
    @team_count = current_client.business.clients.count
    if @team_count == 2
      return redirect_to clients_dashboards_teams_path, notice: "You have reached your quota (#{@team_count}/2)"
    end

    super
  end

  def after_invite_path_for(_)
    clients_dashboards_teams_path
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
