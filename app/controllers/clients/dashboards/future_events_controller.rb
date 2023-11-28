# frozen_string_literal: true

class Clients::Dashboards::FutureEventsController < ApplicationController
  include Dashboard::LayoutDetail
  include Dashboard::Auth
  include Dashboard::Verified

  def index
    @closest_event = Event.where('date >= ?', Time.zone.today)
                          .order('date ASC').first
    @future_events = Event.where('date > ?', Time.zone.today)
                          .where('date <= ?', Time.zone.today + 60.days)
                          .where.not(id: @closest_event.id)

    @days_until = (@closest_event.date - Time.zone.today).to_i
  end

  def show; end
end
