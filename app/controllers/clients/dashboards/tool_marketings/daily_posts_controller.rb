# frozen_string_literal: true

class Clients::Dashboards::ToolMarketings::DailyPostsController < ApplicationController
  include Dashboard::LayoutDetail
  include Dashboard::Auth
  include Dashboard::Verified

  def index
    @histories = current_client.business.ai_results
                               .where(kind: 'ai.marketing.generative.daily_post')
                               .where(created_at: 7.days.ago..Time.zone.now)
                               .order(created_at: :desc)
  end

  def new
    business = current_client.business
    limit = business.business_token_limits.find_by(kind: 'ai.marketing.generative.daily_post')
    consumption_count = business.business_token_consumptions
                                .where(kind: 'ai.marketing.generative.daily_post')
                                .where(created_at: Date.current.beginning_of_week..Date.current.end_of_week.end_of_day)
                                .count

    @percentage = consumption_count.positive? ? ((limit.limit.to_f - consumption_count.to_f) / limit.limit.to_f) * 100 : 100.0
    @balance = "#{[(limit.limit - consumption_count), 0].max}/#{limit.limit}"
    @balance_left = limit.limit - consumption_count
    @result = business.ai_results.where(kind: 'ai.marketing.generative.daily_post').order(created_at: :desc).first
  end

  def create
    @result = nil

    business = current_client.business
    token_limit = business.business_token_limits.find_by(kind: 'ai.marketing.generative.daily_post')

    if token_limit.limit_by == 'weekly'
      consumptions = business.business_token_consumptions
                             .where(kind: 'ai.marketing.generative.daily_post')
                             .where(created_at: Date.current.beginning_of_week..Date.current.end_of_week.end_of_day)
                             .count

      if consumptions >= token_limit.limit
        return redirect_to new_clients_dashboards_tool_marketings_daily_post_path,
                           alert: 'You\'ve reached the quota for this week.'
      end
    end

    begin
      client = OpenAI::Client.new
      messages = [
        { role: 'system',
          content: ''"
You are a marketing expert for company named '#{current_client.business.name}'.
ONLY give response.
"'' },
        { role: 'user',
          content: ''"
Result in accurate local Bahasa Melayu in Malaysia.
Do not mix with Indonesian word.
I'm a business owner.
My business name is #{current_client.business.name}.
#{"My business google map link is #{current_client.business.gmap_link}" if current_client.business.gmap_link.present?}
Give me a content I can post daily to my social media to keep my
followers in loop. You can use emojis, fancy words, bullet points etc. Be creative.
ONLY gives the answer for today. Result in Bahasa Melayu.
ONLY include location if provided.
ONLY include opening hours if provided, otherwise state 'We are open today!'
ONLY gives relevant hashtag.
DO NOT assume customer other product name.
DO NOT assume how the product was made.
DO NOT assume the user's social media alias or link.
"'' }
      ]

      http_response = client.chat(
        parameters: {
          model: current_client.business.business_subscription.model_plan,
          messages:,
          temperature: 0.7
        }
      )

      @result = http_response.dig('choices', 0, 'message', 'content')

      business.business_token_consumptions.create(
        kind: 'ai.marketing.generative.daily_post'
      )
      ai_result = business.ai_results.create(
        kind: 'ai.marketing.generative.daily_post',
        input_text: messages,
        output_text: @result&.strip || nil,
        api_response: http_response,
        user_id: current_client.id
      )

      ai_result.save
      redirect_to new_clients_dashboards_tool_marketings_daily_post_path, success: 'Copywriting generated!'
    rescue StandardError
      redirect_to new_clients_dashboards_tool_marketings_daily_post_path, success: 'Oh oh. Something went wrong.'
    end
  end
end
