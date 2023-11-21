# frozen_string_literal: true

class Clients::Dashboards::ToolMoodboardsController < ApplicationController
  include Dashboard::LayoutDetail
  include Dashboard::Auth
  include Dashboard::Verified

  def show
    business = current_client.business

    @gen_banners = business.business_token_consumptions
                           .where(kind: 'ai.moodboard.generative.banner')
                           .where(created_at: Date.current.beginning_of_week..Date.current.end_of_week.end_of_day)
                           .count

    limit_banner = business.business_token_limits.find_by(kind: 'ai.moodboard.generative.banner')
    @gen_banners_used = @gen_banners.present? ? ((limit_banner.limit.to_f - @gen_banners.to_f) / limit_banner.limit.to_f) * 100 : 100.0

    @gen_interior = business.business_token_consumptions
                            .where(kind: 'ai.moodboard.generative.interior_design')
                            .where(created_at: Date.current.beginning_of_week..Date.current.end_of_week.end_of_day)
                            .count

    limit_interior = business.business_token_limits.find_by(kind: 'ai.moodboard.generative.interior_design')
    @gen_interior_used = @gen_interior.present? ? ((limit_interior.limit.to_f - @gen_interior.to_f) / limit_interior.limit.to_f) * 100 : 100.0
  end
end
