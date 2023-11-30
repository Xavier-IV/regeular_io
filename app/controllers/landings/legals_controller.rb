# frozen_string_literal: true

class Landings::LegalsController < ApplicationController
  layout 'business_v2'
  def terms_and_conditions; end

  def cookie_policy; end

  def privacy_policy; end

  def disclaimer; end

  def acceptable_use_policy; end
end
