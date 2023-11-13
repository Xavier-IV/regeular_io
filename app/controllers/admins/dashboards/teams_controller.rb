class Admins::Dashboards::TeamsController < ApplicationController
  include AdminLayout

  def index
    @teams = Admin.all.order(created_at: :asc)
  end
end
