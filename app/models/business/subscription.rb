# frozen_string_literal: true

class Business::Subscription < ApplicationRecord
  belongs_to :business

  after_create :observe_plan
  after_update :refresh_plan

  def model_plan
    return 'gpt-3.5-turbo' if plan == 'Microenterprise'

    'gpt-4'
  end

  private

  def observe_plan
    return unless status == 'active'
    return unless Time.zone.now.between?(start_date, end_date)

    if plan == 'Microenterprise'
      business.business_token_limits.create(
        [
          { kind: 'ai.marketing.generative.viral_content_idea', limit: 5, limit_by: 'week' },
          { kind: 'ai.marketing.generative.copywriting', limit: 5, limit_by: 'week' },
          { kind: 'ai.marketing.generative.daily_post', limit: 5, limit_by: 'week' }
        ]
      )
    end
    return unless plan == 'SME Business'

    business.business_token_limits.create(
      [
        { kind: 'ai.marketing.generative.viral_content_idea', limit: 10, limit_by: 'week' },
        { kind: 'ai.marketing.generative.copywriting', limit: 10, limit_by: 'week' },
        { kind: 'ai.marketing.generative.daily_post', limit: 10, limit_by: 'week' }
      ]
    )
  end

  def refresh_plan
    return unless status == 'active'
    return unless Time.zone.now.between?(start_date, end_date)

    if plan == 'Microenterprise'
      business.business_token_limits
              .where(kind: [
                       'ai.marketing.generative.viral_content_idea',
                       'ai.marketing.generative.copywriting',
                       'ai.marketing.generative.daily_post'
                     ])
              .update(limit: 5)
    end
    return unless plan == 'SME Business'

    business.business_token_limits
            .where(kind: [
                     'ai.marketing.generative.viral_content_idea',
                     'ai.marketing.generative.copywriting',
                     'ai.marketing.generative.daily_post'
                   ])
            .update(limit: 10)
  end
end
