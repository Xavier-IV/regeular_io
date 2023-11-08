# frozen_string_literal: true

module AdminLayout
  extend ActiveSupport::Concern
  include Pundit::Authorization

  included do
    include Pundit::Authorization

    before_action :authenticate_admin!
    layout 'admin/dashboard'
  end

  protected

  def pundit_user
    current_admin
  end
end
