# frozen_string_literal: true

class Clients::Dashboards::ToolMarketingsController < ApplicationController
  include Dashboard::LayoutDetail
  include Dashboard::Auth
  include Dashboard::Verified

  def show
    business = current_client.business
    @limits = business.business_token_limits
    @token_usages = calculate_token_usages(business)
  end

  private

  def calculate_token_usages(business)
    token_kinds = %w[ai.marketing.generative.copywriting
                     ai.marketing.generative.viral_content_idea
                     ai.marketing.generative.daily_post
                     ai.marketing.generative.engagement]

    token_usages = {}

    token_kinds.each do |kind|
      token_usages[kind] = calculate_usage(business, kind)
      set_percentage_instance_variable(kind, token_usages[kind])
    end

    token_usages
  end

  def calculate_usage(business, kind)
    business.business_token_consumptions
            .where(kind:)
            .where(created_at: Date.current.beginning_of_week..Date.current.end_of_week.end_of_day)
            .count
  end

  def set_percentage_instance_variable(kind, used)
    limit = current_client.business.business_token_limits.find_by(kind:)
    percentage_variable_name = "@percentage_#{kind.gsub('.', '_')}"
    instance_variable_set(percentage_variable_name, calculate_percentage(limit, used))
  end

  def calculate_percentage(limit, used)
    return 100.0 if limit.blank?

    used.present? ? ([(limit.limit.to_f - used.to_f), 0].max / limit.limit.to_f) * 100 : 100.0
  end
end
