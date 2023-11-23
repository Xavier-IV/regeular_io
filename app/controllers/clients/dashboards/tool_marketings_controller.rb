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

    @gen_daily_engagement_used = business.business_token_consumptions
                                         .where(kind: 'ai.marketing.generative.engagement')
                                         .where(created_at: Date.current.beginning_of_week..Date.current.end_of_week.end_of_day)
                                         .count

    limit_viral = business.business_token_limits.find_by(kind: 'ai.marketing.generative.viral_content_idea')
    @percentage_viral = if @gen_viral_used.present?
                          ([(limit_viral.limit.to_f - @gen_viral_used.to_f),
                            0].max / limit_viral.limit.to_f) * 100
                        else
                          100.0
                        end

    limit_copy = business.business_token_limits.find_by(kind: 'ai.marketing.generative.copywriting')
    @percentage_copy = if @gen_copywriting_used.present?
                         ([(limit_copy.limit.to_f - @gen_copywriting_used.to_f),
                           0].max / limit_copy.limit.to_f) * 100
                       else
                         100.0
                       end

    limit_daily_post = business.business_token_limits.find_by(kind: 'ai.marketing.generative.daily_post')
    @percentage_daily_post = if @gen_daily_post_used.present?
                               ([
                                 (limit_daily_post.limit.to_f - @gen_daily_post_used.to_f), 0
                               ].max / limit_daily_post.limit.to_f) * 100
                             else
                               100.0
                             end

    limit_daily_engagement = business.business_token_limits.find_by(kind: 'ai.marketing.generative.engagement')
    @percentage_daily_engagement = if @gen_daily_engagement_used.present?
                                     ([
                                       (limit_daily_engagement.limit.to_f - @gen_daily_engagement_used.to_f), 0
                                     ].max / limit_daily_engagement.limit.to_f) * 100
                                   else
                                     100.0
                                   end
  end
end
