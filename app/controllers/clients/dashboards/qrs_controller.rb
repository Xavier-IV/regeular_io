# frozen_string_literal: true

class Clients::Dashboards::QrsController < ApplicationController
  include Dashboard::Layout
  include Dashboard::Auth
  include Dashboard::Verified

  def index; end
end
