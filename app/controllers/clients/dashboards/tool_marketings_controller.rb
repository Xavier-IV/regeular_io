# frozen_string_literal: true

class Clients::Dashboards::ToolMarketingsController < ApplicationController
  include Dashboard::LayoutDetail
  include Dashboard::Auth
  include Dashboard::Verified

  def show
    business = current_client.business
    @limits = business.business_token_limits

    @gen_copywriting_used = business.business_token_consumptions
                                    .where(kind: 'ai.marketing.generative.copywriting')
                                    .where(created_at: Date.current.beginning_of_week..Date.current.end_of_week.end_of_day)
                                    .count

    @gen_viral_used = business.business_token_consumptions
                              .where(kind: 'ai.marketing.generative.viral_content_idea')
                              .where(created_at: Date.current.beginning_of_week..Date.current.end_of_week.end_of_day)
                              .count

    @gen_daily_post_used = business.business_token_consumptions
                                   .where(kind: 'ai.marketing.generative.daily_post')
                                   .where(created_at: Date.current.beginning_of_week..Date.current.end_of_week.end_of_day)
                                   .count

    limit_viral = business.business_token_limits.find_by(kind: 'ai.marketing.generative.viral_content_idea')
    @percentage_viral = @gen_viral_used.present? ? ((limit_viral.limit.to_f - @gen_viral_used.to_f) / limit_viral.limit.to_f) * 100 : 100.0

    limit_copy = business.business_token_limits.find_by(kind: 'ai.marketing.generative.copywriting')
    @percentage_copy = @gen_copywriting_used.present? ? ((limit_copy.limit.to_f - @gen_copywriting_used.to_f) / limit_copy.limit.to_f) * 100 : 100.0

    limit_daily_post = business.business_token_limits.find_by(kind: 'ai.marketing.generative.daily_post')
    @percentage_daily_post = @gen_daily_post_used.present? ? ((limit_daily_post.limit.to_f - @gen_daily_post_used.to_f) / limit_daily_post.limit.to_f) * 100 : 100.0
  end
end
