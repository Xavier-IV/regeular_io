# frozen_string_literal: true

class Dashboards::RegularsController < ApplicationController
  include Pundit::Authorization

  before_action :authenticate_user!
  layout 'business/dashboard'

  def index; end
end
